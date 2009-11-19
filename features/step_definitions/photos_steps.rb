Given /^I have photos named (.+)$/ do |titles|
  titles.split(', ').each do |title|
    Photo.create!(:image_file_name => "../upload_files/#{title}")
  end
end

