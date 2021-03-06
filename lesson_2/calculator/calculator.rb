require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def messages(message, lang)
  if lang != 'es'
    lang = 'en'
  end
  prompt(MESSAGES[lang][message])
end

def valid_number?(num)
  num.match(/\A[0-9]*\.[0-9]*\z/) || num.match(/\A[0-9]+\z/)
end

def operation_to_message(op, lang)
  case op
  when '1'
    messages("adding_message", lang)
  when '2'
    messages("subtracting_message", lang)
  when '3'
    messages("multiplying_message", lang)
  when '4'
    messages("dividing_message", lang)
  end
end

language = <<-MSG
Choose your language:
1) Type 'es' for spanish
2) Type 'en' for english

note: If nothing is typed we will use english as our default language.
MSG

prompt(language)

lang = Kernel.gets().chomp()

messages('welcome', lang)

name = ''

loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    messages('valid_name', lang)
  else
    break
  end
end

messages('greeting', lang)
prompt("#{name}. :-)")

loop do
  number1 = ''

  loop do
    messages('first_num', lang)
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      messages('valid_number', lang)
    end
  end

  number2 = ''

  loop do
    messages('second_num', lang)
    number2 = Kernel.gets().chomp()

    if valid_number?(number2)
      break
    else
      messages('valid_number', lang)
    end
  end

  messages("operator_prompt", lang)

  operator = ''

  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      messages('choose', lang)
    end
  end

  result = case operator
           when '1'
             number1.to_f() + number2.to_f()
           when '2'
             number1.to_f() - number2.to_f()
           when '3'
             number1.to_f() * number2.to_f()
           when '4'
             number1.to_f() / number2.to_f()
           end

  operation_to_message(operator, lang)

  if lang == 'es'
    prompt("El resultado es: #{format('%02.2f', result)}.")
  else
    prompt("The result is: #{format('%02.2f', result)}.")
  end

  messages('repeat?', lang)
  answer = Kernel.gets().chomp()

  break unless answer.downcase() == 'y'

  system('clear') || system('cls')
end

messages('farewell', lang)
