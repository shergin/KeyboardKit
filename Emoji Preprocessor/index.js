//console.log("Hello! I am KeyboardKit Emoji Preprocessor!");

//var requestPromise = require('request-promise');

var emojis = require('./emoji.json');

//console.log(emojis)

function generateSwiftArray(emojis) {
  var swiftCode = '';
  var swiftStructs = []
  for (var i = 0; i < emojis.length; i++) {
    var emoji = emojis[i];

    if (!emoji.has_img_apple) {
      continue;
    }

    var character = emoji.unified.split("-").map(function(code) { return eval('"\\u{' + code + '}"') }).join("")

    var name = emoji.name ? '"' + emoji.name + '"' : "nil";
    var category = emoji.category ? '.' + emoji.category + '' : "nil";
    var shortNames = emoji.short_names ? '[' + emoji.short_names.map(function(shortName) {return '"' + shortName + '"'}).join(', ') + ']' : 'nil';

    var swiftStruct = 'KeyboardEmoji(character: "' + character + '", name: ' + name + ', shortNames: ' + shortNames + ', category: ' + category + ')';

    swiftStructs.push(swiftStruct)

    if (i > 10) {
      break
    }
  }

  swiftCode = "let predefinedEmojis: [KeyboardEmoji] = [\n" + swiftStructs.map(function(swiftStruct) { return "  " + swiftStruct + ",\n"}).join("") + "]\n"

  console.log(swiftCode)
}

//generateSwiftArray(emojis);

function createEmojiKeywords() {
  var emojilib = require("emojilib");
  var map = {};
  var lib = emojilib.lib;
  for (var name in lib) {
    var item = lib[name];
    var emoji = item.char
    var keywords = item.keywords || []
    map[emoji] = keywords
  }
  return map
}

function generateStringsArray(emojis) {
  var keywordsMap = createEmojiKeywords()

  var characters = []
  var names = []
  var categories = []
  var shortNames = []
  var keywords = []

  var code = '';

  for (var i = 0; i < emojis.length; i++) {
    var emoji = emojis[i];

    if (!emoji.has_img_apple) {
      continue;
    }

    var character = emoji.unified.split("-").map(function(code) { return eval('"\\u{' + code + '}"') }).join("")
    var name = emoji.name || "";
    var category = emoji.category || "None";
    var shortName = (emoji.short_names || []).join(";");
    var keyword = (keywordsMap[character] || []).join(";")

    characters.push(character)
    names.push(name)
    categories.push(category)
    shortNames.push(shortName)
    keywords.push(keyword)
  }

  function quote(string) { return '"' + string + '"' }
  function dot(string) { return '.' + string }

  code += "internal let predefinedEmojiCharacters: [String] = [" + characters.map(quote).join(', ') + "]\n"
  code += "internal let predefinedEmojiNames: [String] = [" + names.map(quote).join(', ') + "]\n"
  code += "internal let predefinedEmojiCategories: [KeyboardEmojiCategory] = [" + categories.map(dot).join(', ') + "]\n"
  code += "internal let predefinedEmojiShortNames: [String] = [" + shortNames.map(quote).join(', ') + "]\n"
  code += "internal let predefinedEmojiKeywords: [String] = [" + keywords.map(quote).join(', ') + "]\n"

  //swiftCode = "let predefinedEmojiStrings: [[String?]] = [\n" + swiftStructs.map(function(swiftStruct) { return "  " + swiftStruct + ",\n"}).join("") + "]\n"

  console.log(code)
}

generateStringsArray(emojis);
