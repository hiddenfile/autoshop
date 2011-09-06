module AdminPanel::AdminApplicationHelper
 def has_active_class?(href)
    current_page?(href) ? {:class => "active"} : []
 end

  def truncate_html(html)
    result=''
    Nokogiri::HTML.fragment(html).children.each {|elem| result+=elem.to_html if result.length <20}
    result
  end
end
