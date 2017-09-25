module RubyTry  

  require 'open-uri'
  require 'nokogiri'
  doc = Nokogiri::HTML(open('https://www.port-monitor.com/plans-and-pricing'))
    
  # two final arrays
  numbers_array = []
  success_array = []
    
  doc.css('.product').each do |product|   # let's find all <div class="product">
    
    content = product.content
    nums = content.scan(/[\d.]+/)         # extract all numbers from it
    
    numbers_array.push(nums)    
    innerHtml = Nokogiri::HTML(product.inner_html)
    
    div_success_array = []                # temporary array for storing span class='label label-success'>
    innerHtml.xpath("//span[contains(@class, 'label label-success')]").each do |succession|
      
      if succession.text.upcase == "YES"  # convert yes and no to true and false
        div_success_array.push(true)
      else 
        div_success_array.push(false)
      end
    end  
    
    success_array.push(div_success_array)  
  end
  
  final_array = []
  
  for i in 0..numbers_array.length-1
    nums_array = numbers_array[i]     # from array of array
    suc_array  = success_array[i]
    final_res = Hash[
                  "monitors" => nums_array[0],
                  "check_rate" => nums_array[1],
                  "history" => nums_array[2],
                  "multiple_notifications" => suc_array[0],
                  "push_notifications" => suc_array[1],
                  "price" => nums_array[3]]
    final_array.push(final_res)
end

puts final_array
gets
  
end
