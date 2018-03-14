require('onmt.init')
local restserver = require("restserver")
local port = 8080
local server = restserver:new():port(port)

opt = {model='model.t7', gpuid=-1, beam_size=3, max_sent_length=30, n_best=1, replace_unk=true}
onmt.translate.Translator.init(opt)

local function tokenize(input)
  tokens = {}
  for token in input:gmatch("%w+") do table.insert(tokens, token) end
  return tokens
end

local function generate_question(input)
  srcTokens = tokenize(input)
  local srcBatch = {}
  local srcWordsBatch = {}
  local srcFeaturesBatch = {}
  local tgtWordsBatch
  local tgtFeaturesBatch
  local srcWords, srcFeats = onmt.utils.Features.extract(srcTokens)
  table.insert(srcWordsBatch, srcWords)
  table.insert(srcFeaturesBatch, srcFeats)
  local predBatch, info = onmt.translate.Translator.translate(srcWordsBatch, srcFeaturesBatch, tgtWordsBatch, tgtFeaturesBatch)
  local question = table.concat(predBatch[1], " ")
  return question
end

--test
generate_question('xyz is the president of abcd')

server:add_resource("generate_question", {
	{
		method = "GET",
		path = "/",
		consumes = "application/json",
		produces = "application/json",
		input_schema = {input = {type = "string"}},
		handler = function(input)
			local input_text = input.GET.input
			local result = {
				question = generate_question(input_text)
			}
			return restserver.response():status(200):entity(result)
		end,
	}
})

server:enable("restserver.xavante"):start()
