require 'json'
require 'http'


#---------------------------------WORD CREATION----------------------------------

word = Word.new
word.entry = "cool"

# --------------------------------WORDS API--------------------------------

headers = { "X-Mashape-Key" => ENV["UNIREST_KEY"] }
url = "https://wordsapiv1.p.mashape.com/words/#{word.entry}"
callback = HTTP.get(url, headers: headers)
response = JSON.parse(callback)

response['results'].each do |result|
  detail = Detail.new
  detail.word = word
  detail.nature = result['partOfSpeech']
  detail.definition = result['definition']
  detail.nature = result['nature']
  detail.synonyms = result['synonyms']
  detail.examples = result['examples']
  detail.save!
end


# --------------------------------YANDEX TRANSLATION--------------------------------
direction = "en-fr"
yandex_base = "https://translate.yandex.net/api/v1.5/tr.json/translate"
yandex_dic = "https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key=#{ENV["YANDEX_DIC_KEY"]}&lang=#{direction}&text=#{word.entry}"
yandex_trl = yandex_base + "?key=#{ENV["YANDEX_KEY"]}" + "&text=#{word.entry}" + "&lang=#{direction}"

callback = HTTP.get(yandex_dic)
response = JSON.parse(callback)

traductions = []

response['def']&.each do |word_nature|
  word_nature['tr'].each do |trad|
    traductions << trad['text']
    trad['syn']&.each do |syn|
      traductions << syn['text']
    end
  end
end

word.translation = traductions
word.save!
