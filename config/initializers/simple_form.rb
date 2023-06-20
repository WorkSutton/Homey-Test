# frozen_string_literal: true
#
# Uncomment this and change the path if necessary to include your own
# components.
# See https://github.com/heartcombo/simple_form#custom-components to know
# more about custom components.
# Dir[Rails.root.join('lib/components/**/*.rb')].each { |f| require f }
#
# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # Wrappers are used by the form builder to generate a
  # complete input. You can remove any component from the
  # wrapper, change the order or even add your own to the
  # stack. The options given below are used to wrap the
  # whole input.


#   # ---------------  Original SF default configuration  ----------------------
#   config.wrappers :default, class: :input,
#     hint_class: :field_with_hint, error_class: :field_with_errors, valid_class: :field_without_errors do |b|
#     ## Extensions enabled by default
#     # Any of these extensions can be disabled for a
#     # given input by passing: `f.input EXTENSION_NAME => false`.
#     # You can make any of these extensions optional by
#     # renaming `b.use` to `b.optional`.

#     # Determines whether to use HTML5 (:email, :url, ...)
#     # and required attributes
#     b.use :html5

#     # Calculates placeholders automatically from I18n
#     # You can also pass a string as f.input placeholder: "Placeholder"
#     b.use :placeholder

#     ## Optional extensions
#     # They are disabled unless you pass `f.input EXTENSION_NAME => true`
#     # to the input. If so, they will retrieve the values from the model
#     # if any exists. If you want to enable any of those
#     # extensions by default, you can change `b.optional` to `b.use`.

#     # Calculates maxlength from length validations for string inputs
#     # and/or database column lengths
#     b.optional :maxlength

#     # Calculate minlength from length validations for string inputs
#     b.optional :minlength

#     # Calculates pattern from format validations for string inputs
#     b.optional :pattern

#     # Calculates min and max from length validations for numeric inputs
#     b.optional :min_max

#     # Calculates readonly automatically from readonly attributes
#     b.optional :readonly

#     ## Inputs
#     # b.use :input, class: 'input', error_class: 'is-invalid', valid_class: 'is-valid'
#     b.use :label_input
#     b.use :hint,  wrap_with: { tag: :span, class: :hint }
#     b.use :error, wrap_with: { tag: :span, class: :error }

#     ## full_messages_for
#     # If you want to display the full error message for the attribute, you can
#     # use the component :full_error, like:
#     #
#     # b.use :full_error, wrap_with: { tag: :span, class: :error }
#   end
  # ---------------  END of SF original default configuration ----------------------


  # ---------------  Configurations for Tailwind CSS          ----------------------

  config.wrappers :default, tag: 'div', class: '', error_class: '', valid_class: '' do |b|
    ## Extensions enabled by default
    # Any of these extensions can be disabled for a
    # given input by passing: `f.input EXTENSION_NAME => false`.
    # You can make any of these extensions optional by
    # renaming `b.use` to `b.optional`.

    # Determines whether to use HTML5 (:email, :url, ...)
    # and required attributes
    b.use :html5

    # Calculates placeholders automatically from I18n
    # You can also pass a string as f.input placeholder: "Placeholder"
    b.use :placeholder

    ## Optional extensions
    # They are disabled unless you pass `f.input EXTENSION_NAME => true`
    # to the input. If so, they will retrieve the values from the model
    # if any exists. If you want to enable any of those
    # extensions by default, you can change `b.optional` to `b.use`.

    # Calculates maxlength from length validations for string inputs
    # and/or database column lengths
    b.optional :maxlength

    # Calculate minlength from length validations for string inputs
    b.optional :minlength

    # Calculates pattern from format validations for string inputs
    b.optional :pattern

    # Calculates min and max from length validations for numeric inputs
    b.optional :min_max

    # Calculates readonly automatically from readonly attributes
    b.optional :readonly

    ## Inputs
    # b.use :input, class: 'input', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :label, class: "block text-sm font-medium text-gray-700 mt-4"
    b.use :input,
      class: 'appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm',
      error_class: 'block w-full pr-10 border-red-300 text-red-900 placeholder-red-300 focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm rounded-md'
    b.use :hint,  wrap_with: { tag: :p, class: "mt-2 text-sm text-gray-500" }
    # b.use :error, wrap_with: { tag: :span, class: :error }

    ## full_messages_for
    # If you want to display the full error message for the attribute, you can
    # use the component :full_error, like:
    #
    b.use :full_error, wrap_with: { tag: 'p', class: 'mt-2 text-sm text-red-600' }
  end

  # ---------------  END of Tailwind CSS default configuration ----------------------

  config.wrappers :prepend_string, tag: 'div', class: '', error_class: '', valid_class: '' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label, class: "block text-sm font-medium text-gray-700"

    b.wrapper tag: 'div', class: 'mt-1 flex rounded-md shadow-sm' do |d|
      d.use :prepend
      d.use :input,
        class: "flex-1 min-w-0 block w-full px-3 py-2 rounded-none rounded-r-md focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm border-gray-300",
        error_class: "flex-1 min-w-0 block w-full px-3 py-2 rounded-none rounded-r-md focus:ring-red-500 focus:border-red-500 sm:text-sm border-red-300 text-red-900 placeholder-red-300"
    end
    b.use :full_error, wrap_with: { tag: "p", class: "mt-2 text-sm text-red-600" }
    b.use :hint,  wrap_with: { tag: :p, class: "mt-2 text-sm text-gray-500" }
  end

  config.wrappers :append_string, tag: 'div', class: '', error_class: '', valid_class: '' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label, class: "block text-sm font-medium text-gray-700"

    b.wrapper tag: 'div', class: 'mt-1 flex rounded-md shadow-sm' do |d|
      d.use :input,
        class: "flex-1 min-w-0 block w-full px-3 py-2 rounded-none rounded-l-md focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm border-gray-300",
        error_class: "flex-1 min-w-0 block w-full px-3 py-2 rounded-none rounded-l-md focus:ring-red-500 focus:border-red-500 sm:text-sm border-red-300 text-red-900 placeholder-red-300"
      d.use :append
    end
    b.use :full_error, wrap_with: { tag: "p", class: "mt-2 text-sm text-red-600" }
    b.use :hint,  wrap_with: { tag: :p, class: "mt-2 text-sm text-gray-500" }
  end

  config.wrappers :corner_hint, tag: :div do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.wrapper tag: :div, class: "flex justify-between", error_class: nil, valid_class: nil do |c|
      c.use :label, class: "block text-sm font-medium text-gray-700"
      c.use :hint,  wrap_with: { tag: :span, class: "text-sm text-gray-500" }
    end

    b.use :input,
      class: "appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm",
      error_class: "block w-full pr-10 border-red-300 text-red-900 placeholder-red-300 focus:outline-none focus:ring-red-500 focus:border-red-500 sm:text-sm rounded-md"
    b.use :full_error, wrap_with: { tag: "p", class: "mt-2 text-sm text-red-600" }
  end
  # ---------------  END of Tailwind CSS other configurations  ----------------------

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :default

  # Define the way to render check boxes / radio buttons with labels.
  # Defaults to :nested for bootstrap config.
  #   inline: input + label
  #   nested: label > input
  config.boolean_style = :nested

  # Default class for buttons
  config.button_class = nil # was 'btn'

  # Method used to tidy up errors. Specify any Rails Array method.
  # :first lists the first message for each field.
  # Use :to_sentence to list all errors for each field.
  # config.error_method = :first

  # Default tag used for error notification helper.
  config.error_notification_tag = :div

  # CSS class to add for error notification helper.
  config.error_notification_class = '' # was 'error_notification'

  # Series of attempts to detect a default label method for collection.
  # config.collection_label_methods = [ :to_label, :name, :title, :to_s ]

  # Series of attempts to detect a default value method for collection.
  # config.collection_value_methods = [ :id, :to_s ]

  # You can wrap a collection of radio/check boxes in a pre-defined tag, defaulting to none.
  # config.collection_wrapper_tag = nil

  # You can define the class to use on all collection wrappers. Defaulting to none.
  # config.collection_wrapper_class = nil

  # You can wrap each item in a collection of radio/check boxes with a tag,
  # defaulting to :span.
  # config.item_wrapper_tag = :span

  # You can define a class to use in all item wrappers. Defaulting to none.
  # config.item_wrapper_class = nil

  # How the label text should be generated altogether with the required text.
  # config.label_text = lambda { |label, required, explicit_label| "#{required} #{label}" }
  config.label_text = lambda { |label, required, explicit_label| "#{label}" }

  # You can define the class to use on all labels. Default is nil.
  # config.label_class = nil

  # You can define the default class to be used on forms. Can be overridden
  # with `html: { :class }`. Defaulting to none.
  config.default_form_class = nil
  config.form_class = nil # new in TailwindCSS SF

  # You can define which elements should obtain additional classes
  # config.generate_additional_classes_for = [:wrapper, :label, :input]
  config.generate_additional_classes_for = []

  # Whether attributes are required by default (or not). Default is true.
  # config.required_by_default = true

  # Tell browsers whether to use the native HTML5 validations (novalidate form option).
  # These validations are enabled in SimpleForm's internal config but disabled by default
  # in this configuration, which is recommended due to some quirks from different browsers.
  # To stop SimpleForm from generating the novalidate option, enabling the HTML5 validations,
  # change this configuration to true.
  config.browser_validations = false

  # Custom mappings for input types. This should be a hash containing a regexp
  # to match as key, and the input type that will be used when the field name
  # matches the regexp as value.
  # config.input_mappings = { /count/ => :integer }

  # Custom wrappers for input types. This should be a hash containing an input
  # type as key and the wrapper that will be used for all inputs with specified type.
  # config.wrapper_mappings = { string: :prepend }
  config.wrapper_mappings = {
    string: :default,
    prepend_string: :prepend_string,
    append_string: :append_string,
  }

  # Namespaces where SimpleForm should look for custom input classes that
  # override default inputs.
  # config.custom_inputs_namespaces << "CustomInputs"

  # Default priority for time_zone inputs.
  # config.time_zone_priority = nil

  # Default priority for country inputs.
  # config.country_priority = nil

  # When false, do not use translations for labels.
  # config.translate_labels = true

  # Automatically discover new inputs in Rails' autoload path.
  # config.inputs_discovery = true

  # Cache SimpleForm inputs discovery
  # config.cache_discovery = !Rails.env.development?

  # Default class for inputs
  # config.input_class = nil

  # Define the default class of the input wrapper of the boolean input.
  config.boolean_label_class = 'checkbox'

  # Defines if the default input wrapper class should be included in radio
  # collection wrappers.
  # config.include_default_input_wrapper_class = true

  # Defines which i18n scope will be used in Simple Form.
  # config.i18n_scope = 'simple_form'

  # Defines validation classes to the input_field. By default it's nil.
  # config.input_field_valid_class = 'is-valid'
  # config.input_field_error_class = 'is-invalid'
end
