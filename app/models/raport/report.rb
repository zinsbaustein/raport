module Raport
  class Report < ActiveRecord::Base

    #
    # Constants
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    #
    # Attribute Settings
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    store :query, accessors: [:joins, :where, :select]

    #
    # Plugins
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    mount_uploader :file, FileUploader

    #
    # Concerns
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    #
    # Scopes
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    #
    # State Machine
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    state_machine :state, initial: :pending do
      state :pending
      state :active
      state :finished do
        validates :file, presence: true
      end
      state :failed

      event :pend do
        transition all => :pending
      end

      after_transition on: :pend do |report, transition|
        report.enqueue!
      end

      event :activate do
        transition pending: :active
      end

      event :finish do
        transition [:active, :failed] => :finished
      end

      event :flop do
        transition active: :failed
      end
    end

    #
    # Scopes
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    state_machine.states.each { |state| scope state.name, -> { where(state: state.name.to_s) } }

    scope :by_name, -> (name) { where(name: name) }
    scope :by_user, -> (user) { where(user_type: user.class.name, user_id: user.id) }
    scope :active, -> { where(state: [:pending, :activated]) }
    scope :pendable, -> { where(state: [:finished, :flop]) }
    scope :daily, -> { by_name(:daily) }

    #
    # Associations
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    belongs_to :user, polymorphic: true, class_name: ::Admin

    #
    # Nested Attributes
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    #
    # Validations
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    validates :name, :query, :resource_class_name, :template, :user_id, :action_name, presence: true

    #
    # Callbacks
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    before_validation :set_name, on: :create

    after_create :enqueue!

    #
    # Delegates
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    delegate :email, to: :user, allow_nil: true

    #
    # Instance Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    def perform!
      ReportJob.new(id).perform
    end

    def enqueue!
      ReportsJob.perform_later(self)
    end

    def template_path
      @template_path ||= File.path(template).gsub('app/views', '').split('.').first
    end

    def format
      @format ||= template.scan(/\.(.*?)\./).first.first.to_sym
    end

    def collection
      @collection ||= begin
        query = select.present? ? resource_class.select(*select) : resource_class
        query = query.joins(*joins) if joins.any?
        query = query.where(where) if where.present?
        query.uniq
      end
    end

    def resource_class
      @resource_class ||= resource_class_name.constantize
    end

    def default_filename
      [I18n.l(Time.zone.now, format: :dashed), action_name ? resource_class.human_attribute_name(action_name) : nil, resource_class.model_name.human(count: :other)].join('-')
    end

    def filename
      @filename ||= [name || default_filename, format].join('.').gsub('.csv.csv', '.csv')
    end

    def tmp_filename
      @tmp_filename ||= [filename, tmp_file_identifier].join('.')
    end

    def tmp_file_identifier
      'tempfile'
    end

    def permalink(format = nil)
      [Rails.application.routes.url_helpers.admin_report_path(self.to_param, locale: I18n.locale), format].compact.join('.')
    end
    
    def status_css_classes
      Admin::BaseController.helpers.status_css_class(state).join(' ')
    end
    
    def display_status_name
      self.class.human_state_name(state)
    end

    #
    # Class Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    #
    # Protected
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    protected

    #
    # Private
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    private

    def set_name
      self.name = filename unless name
    end
  end
end
