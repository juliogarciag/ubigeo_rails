class UbigeoInput
  include Formtastic::Inputs::Base
  include Rails.application.routes.url_helpers
  
  attr_reader :ubigeo
  
  def to_html
    input_wrapping do
      load_ubigeo
      department_html << province_html << district_html << hidden_field_html
    end
  end
  
  def wrapper_html_options
    wrapper_html_options_raw.tap do |opts|
      opts[:class] = classes
      opts[:id] ||= wrapper_dom_id
      opts['data-url'] = options[:url] || ubigeo_rails_path
    end
  end
  
  private
  
  def load_ubigeo
    model = builder.object
    
    @ubigeo ||= if options[:ubigeo_model]
      options[:ubigeo_model]
    elsif model.ubigeo
      model.ubigeo
    else
      UbigeoRails::Ubigeo.new
    end
  end
  
  def classes
    (wrapper_classes || '') + " ubigeo_input"
  end
  
  def department_html    
    template.select_tag :ubigeo_department, prompt_department.html_safe, class: 'ubigeo_department', data: {
      selection: (ubigeo.has_department? ? ubigeo.department_part : {})
    }
  end
  
  def province_html
    template.select_tag :ubigeo_province, prompt_province.html_safe, class: 'ubigeo_province', data: {
      selection: (ubigeo.has_province? ? ubigeo.province_part : {})
    }
  end
  
  def district_html
    template.select_tag :ubigeo_district, prompt_district.html_safe, class: 'ubigeo_district', data: {
      selection: (ubigeo.has_district? ? ubigeo.district_part : {})
    }
  end
  
  def hidden_field_html
    builder.hidden_field method, class: 'ubigeo_hidden'
  end
  
  # prompts
  # [dept, prov, district]
  
  def prompt_department
    prompt_by_index 0
  end
  
  def prompt_province
    prompt_by_index 1
  end
  
  def prompt_district
    prompt_by_index 2
  end
  
  def prompt_by_index(index)
    return '' unless options[:prompt]
    return '' unless options[:prompt][index]
    "<option>#{options[:prompt][index]}</option>"
  end
  
end