# encoding: utf-8
class ActiveAdmin::Views::Pages::Base < Arbre::HTML::Document

  private

  # Renders the content for the footer
  def build_footer
    div :id => "footer" do
      para do
      #  "Copyright © #{Date.today.year.to_s} Kraft Foods Mexico "
      #  a href: 'http://creamcheese.herokuapp.com', target: '_blank', do
      #    'Ir al sitio'
      #  end
      end
    end
  end

end
