FactoryGirl.define do
  factory :place do
    title_cs "Albrechtice u Sušice"
    subtitle_cs "Pravěké hradiště Sedlo"
    slug "albrechtice_kt_hradiste_sedlo"
    qr_id "74c00"
    tag_list "pravěk, hradiště"
    address_cs "okr. Klatovy, Plzeňský kraj"
    era_cs "600 př. Kr. až přelom letopočtu, příležitostně i později"
    text_content_cs "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    geo_coordinates "N 49°11'21.99\", E 13°34'19.26\""
  end

  factory :tag do
    sequence(:name) { |n| "stuff#{n}" }
    era false
  end

  factory :user do
    email 'john@example.com'
    password 'password'
    password_confirmation 'password'
  end

  factory :media_item do
    source_url 'http://google.com'
    copyright_cs 'Autor'
    copyright_en 'Autor'
  end

  factory :media_placement do
    title_en 'Video'
    title_cs 'Video'
    sequence(:position)
    # place
    media_item
  end
end
