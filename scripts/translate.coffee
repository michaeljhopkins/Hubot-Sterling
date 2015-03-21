# Description:
#
# lets see how this guy works. should translate everything in specficied channels
# Author:

languages =
  "af": "Afrikaans",
  "sq": "Albanian",
  "ar": "Arabic",
  "az": "Azerbaijani",
  "eu": "Basque",
  "bn": "Bengali",
  "be": "Belarusian",
  "bg": "Bulgarian",
  "ca": "Catalan",
  "zh-CN": "Simplified Chinese",
  "zh-TW": "Traditional Chinese",
  "hr": "Croatian",
  "cs": "Czech",
  "da": "Danish",
  "nl": "Dutch",
  "en": "English",
  "eo": "Esperanto",
  "et": "Estonian",
  "tl": "Filipino",
  "fi": "Finnish",
  "fr": "French",
  "gl": "Galician",
  "ka": "Georgian",
  "de": "German",
  "el": "Greek",
  "gu": "Gujarati",
  "ht": "Haitian Creole",
  "iw": "Hebrew",
  "hi": "Hindi",
  "hu": "Hungarian",
  "is": "Icelandic",
  "id": "Indonesian",
  "ga": "Irish",
  "it": "Italian",
  "ja": "Japanese",
  "kn": "Kannada",
  "ko": "Korean",
  "la": "Latin",
  "lv": "Latvian",
  "lt": "Lithuanian",
  "mk": "Macedonian",
  "ms": "Malay",
  "mt": "Maltese",
  "no": "Norwegian",
  "fa": "Persian",
  "pl": "Polish",
  "pt": "Portuguese",
  "ro": "Romanian",
  "ru": "Russian",
  "sr": "Serbian",
  "sk": "Slovak",
  "sl": "Slovenian",
  "es": "Spanish",
  "sw": "Swahili",
  "sv": "Swedish",
  "ta": "Tamil",
  "te": "Telugu",
  "th": "Thai",
  "tr": "Turkish",
  "uk": "Ukrainian",
  "ur": "Urdu",
  "vi": "Vietnamese",
  "cy": "Welsh",
  "yi": "Yiddish"
module.exports = (robot) ->
  # Find the user by user name from hubot's brain.
  #
  # name - A full or partial name match.
  #
  # Returns a user object if a single user is found, an array of users if more
  # than one user matched the name or false if no user is found.
  findUser = (name) ->
    users = robot.brain.usersForFuzzyName name
    if users.length is 1
      users[0]
    else if users.length > 1
      users
    else
      false

  robot.respond /autotrans me (.{2}) to (.{2})/i, (msg) ->
    messageSender = findUser msg.message.user.name
    if typeof messageSender is 'object'
      messageSender.preferredLanguage = sourceDefault: msg.match[1], targetDefault: msg.match[2]

  robot.hear /^(?!(wilson|wilson|\.|\@wilson|$))(.*)/i, (msg) ->
    messageSender = findUser msg.message.user.name
    if typeof messageSender is 'object'
      src = user.preferredLanguage.sourceDefault
      tgt = user.preferredLanguage.targetDefault
      trm = msg.match[2]
      room = msg.message.user.room
      if(room == 'hello-printing' || room == 'random')
        roomToAutoTransTo = 'crappypoemsbywilson'
        msg.http("https://translate.google.com/translate_a/t").query({client: 't', hl: 'en', multires: 1, sc: 1, sl: src, ssel: 0, tl: tgt, tsel: 0, uptl: "en", text: trm}).header('User-Agent', 'Mozilla/5.0').get() (err, res, body) ->
          data = body
          if data.length > 4 and data[0] == '['
            parsed = eval(data)
          parsed = parsed[0] and parsed[0][0] and parsed[0][0][0]
          if parsed
            if msg.match[2] is undefined
            else
              robot.messageRoom roomToAutoTransTo, parsed