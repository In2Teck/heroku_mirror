xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Philadelphia - Recetas"
    xml.description "Deliciosas recetas"
    xml.link root_url

    for receta in @recetas
      xml.item do
        xml.title receta.titulo
        xml.pubDate receta.created_at.to_s(:rfc822) unless receta.created_at.nil?
        xml.link receta_path(receta.id, receta.slug)
        xml.guid receta_path(receta.id, receta.slug)
      end
    end
  end
end
