module ApplicationHelper

  def title(title_content)
    if title_content.present? # si le paramètre title_content est présent
      "Bestneighbor | " << title_content# le title reprend la chaîne en paramètre suivie de " | Mon Site"
    else
      "Bestneighbor" # sinon, par défaut, le title sera "Mon site"
    end
  end

  def description(description_content)
    if description_content.present?
      description_content << " | Bestneighbor"
    else
      "Bestneighbor - Services entre voisins - courses et covoiturage" # sinon, par défaut, le title sera "Mon site"
    end
  end

end
