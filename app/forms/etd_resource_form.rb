# frozen_string_literal: true

# Generated via
#  `rails generate hyrax:work_resource EtdResource`
#
# @see https://github.com/samvera/hyrax/wiki/Hyrax-Valkyrie-Usage-Guide#forms
# @see https://github.com/samvera/valkyrie/wiki/ChangeSets-and-Dirty-Tracking
class EtdResourceForm < Hyrax::Forms::ResourceForm(EtdResource)
  # Commented out basic_metadata because the terms were added to the resource's yaml
  # so we can customize it
  # include Hyrax::FormFields(:basic_metadata)
  include Hyrax::FormFields(:bulkrax_metadata)
  include Hyrax::FormFields(:etd_resource)
  include Hyrax::FormFields(:with_pdf_viewer)
  include Hyrax::FormFields(:with_video_embed)
  include VideoEmbedBehavior::Validation
  # this duplicates Hyrax::BasicMetadataFormFieldsBehavior behavior which previously
  # came in dynamically via lib/hyrax/form_fields.rb
  include BasedNearFormFieldsBehavior
  # Define custom form fields using the Valkyrie::ChangeSet interface
  #
  # property :my_custom_form_field

  # if you want a field in the form, but it doesn't have a directly corresponding
  # model attribute, make it virtual
  #
  # property :user_input_not_destined_for_the_model, virtual: true
end
