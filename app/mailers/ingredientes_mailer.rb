# encoding: utf-8

class IngredientesMailer < ActionMailer::Base
  default from: "philadelphia@philadelphia.com.mx"
  add_template_helper RecetaHelper

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.ingredientes_mailer.ingredientes.subject
  #
  def ingredientes(recipient, recipe_id)
    @receta = Recipe.find(recipe_id)

    mail to: recipient, subject: "¿Lista para cocinar fácil y delicioso?"
  end
end
