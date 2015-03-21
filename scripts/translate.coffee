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
  robot.hear /^(?!(wilson|wilson|\.|\@wilson|$))(.*)/i, (msg) ->
    user = msg.message.user.name
    term = msg.match[2]
    room = msg.message.user.room
    if(room == 'hello-printing' || room == 'random')
      r = 'crappypoemsbywilson'
      if(user == 'trungrueta')
        source = 'auto'
        target = 'en'
      else
        source = 'auto'
        target = 'vi'
        msg.http("https://translate.google.com/translate_a/t").query({client: 't', hl: 'en', multires: 1, sc: 1, sl: source, ssel: 0, tl: target, tsel: 0, uptl: "en", text: term}).header('User-Agent', 'Mozilla/5.0').get() (err, res, body) ->
          data = body
          if data.length > 4 and data[0] == '['
            parsed = eval(data)
            language = languages[parsed[2]]
            parsed = parsed[0] and parsed[0][0] and parsed[0][0][0]
            if parsed
              if msg.match[2] is undefined
              else
                robot.messageRoom r, parsed