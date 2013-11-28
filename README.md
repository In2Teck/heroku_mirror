### Usos

Agregar usos a receta.

    receta = Recipe.find(x)
    receta.usos << Uso.find(y)

Encontrar por uso.
    
    Recipe.includes(:usos).where("usos.id = 1")


### Recetas de la comunidad

1. Exportar en JSON

        recetas = []
        Receta.includes(:usuario).filtro(:aprobadas).each do |r|
          recetas << { :titulo => r.nombre, :ingredientes => r.ingredientes, :preparacion => r.preparacion, :comunidad_nombre => r.usuario.nombre, :foto => r.foto.url }
        end
        puts recetas.to_json

2. Importar

        def troll_level str
          str = str.gsub /([^a-z]+)/i, ''
          size = str.size
          up_size = str.gsub(/([^A-Z]+)/, '').size.to_f
          up_size/size
        end

        def download_pic(url)
          extname = File.extname(url)
          basename = File.basename(url, extname)
          
          file = Tempfile.new([basename, extname])
          file.binmode
          
          io = open(URI.parse(url)) do |data|  
            file.write data.read
          end
          
          file.rewind
          file
        end

        recetas = JSON.parse File.open("/home/sputnik3/Desktop/recetas_comunidad.json").read
        recetas.each do |r|
          foto = r.delete 'foto'
          receta = Recipe.new r
          receta.pic_big = download_pic foto
          receta.pic_small = download_pic foto
          
          receta.titulo = receta.titulo.capitalize unless troll_level(receta.titulo) < 0.25
          receta.slug = receta.titulo.parameterize
          receta.etiquetas = receta.titulo.parameterize(" ").split(" ").uniq.join(" ")
          receta.ingredientes = receta.ingredientes.downcase unless troll_level(receta.ingredientes) < 0.25
          receta.preparacion = receta.preparacion.downcase unless troll_level(receta.preparacion) < 0.25
          receta.save :validate => false
        end

        Recipe.where("comunidad_autor IS NOT NULL").each do |r|
          r.usos << Uso.find(8)
        end
