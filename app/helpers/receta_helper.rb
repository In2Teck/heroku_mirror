module RecetaHelper
  def ingredientes ingredientes
    prev = ''

    ff = []

    # Necesitamos agregar dos líneas nuevas debido a que el último elemento no entra  en el loop de each_cons
    ingredientes << "\n\n"

    regex = /\b(\d[\s\d\/.]*?\s+(?:pizcas?|sobres?|kilos?|latas?|cditas?|hojas?|(?:[pt]z|cd)as?|[km]?g|ml|L)\.?)\s+(de)?\b\s*(.+?)\s*$/iu
    ingredientes.lines.each_cons(2) do |ingrediente, ingrediente_next|
      if !ingrediente.parameterize.empty?
        if regex.match(ingrediente)
          ff << ingrediente.sub(regex){ "<li class='ingrediente' itemprop='ingredients'><span class='cantidad'>#{$1}</span> #{$2} <span class='nombre'>#{$3}</span></li>" }
        elsif
          ff << (ingrediente_next.parameterize.empty? && prev.parameterize.empty? ?
            "<li class='instruccion nobullet'><strong>#{ingrediente}</strong></li>"
              :
            "<li class='ingrediente' itemprop='ingredients'><span class='nombre'>#{ingrediente}</span></li>"
          )
        end
      end
      prev = ingrediente
    end
    ff.join("").html_safe
  end
end
