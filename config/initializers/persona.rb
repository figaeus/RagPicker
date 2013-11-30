PERSONA_CONFIG = YAML.load_file(
    Rails.root.join('config/persona.yml')
  )[Rails.env]
