# SemVer नियम

![तीन जुड़े हुए संस्करण मील के पत्थरों का अमूर्त चित्रण](../assets/semver-rules-hero.png)

कोडिंग एजेंटों के लिए यह पोर्टेबल प्लगइन रिलीज़ की योजना और समीक्षा करते समय
आधिकारिक [Semantic Versioning 2.0.0](https://semver.org/) विनिर्देशन लागू करता है।

[English](../README.md) · [中文（简体）](README.zh-CN.md) · [Español](README.es.md) · [Português (Brasil)](README.pt-BR.md)

## उपयोग का मामला और हल की जाने वाली समस्या

इस plugin का उपयोग तब करें जब किसी agent को तय करना हो कि परिवर्तनों के समूह से
`major`, `minor`, `patch` या कोई release नहीं बननी चाहिए, खासकर release planning,
pull request review, changelog तैयारी या version audit के दौरान।

यह release से जुड़ी एक आम समस्या हल करता है: version bump अक्सर commit labels,
अनुमान या diff के आकार के आधार पर चुन लिया जाता है। SemVer इसके बजाय घोषित
public API और compatibility impact पर निर्भर करता है। यह plugin agent के सामने
यही नियम बनाए रखता है, वास्तविक परिवर्तनों की जाँच में मदद करता है और release
recommendation को समझाना आसान बनाता है।

## सुविधाएँ

- `semver`: अगला संस्करण चुनता है और संस्करण की संरचना तथा प्राथमिकता जाँचता है।
- `semver-review`: परिवर्तनों की समीक्षा करता है और `major`, `minor`, `patch`,
  या कोई रिलीज़ नहीं, की सिफारिश करता है।
- सत्र और सब-एजेंट शुरू होने पर hooks नियमों का संक्षिप्त स्मरण लोड करते हैं; होस्ट के
  Node.js के अतिरिक्त किसी बाहरी निर्भरता की आवश्यकता नहीं है।

## समर्थित परिवेश

| परिवेश | एकीकरण |
| --- | --- |
| Codex | manifest, skills और hooks |
| Claude Code | manifest, skills और hooks |
| Gemini CLI | extension, context, skills और session hook |
| GitHub Copilot CLI | plugin, skills और hooks |
| OpenCode और Cursor | `AGENTS.md` द्वारा पोर्टेबल निर्देश |

## स्थापना

### Codex

```sh
codex plugin marketplace add LenoSeibert/semver-plugin
codex plugin add semver-plugin@semver-plugin
```

`/hooks` खोलें, hooks की समीक्षा करके उन्हें अनुमति दें, फिर नया संवाद शुरू करें।

### Claude Code

```sh
claude plugin marketplace add LenoSeibert/semver-plugin
claude plugin install semver-plugin@semver-plugin
```

`/reload-plugins` चलाएँ या नया सत्र शुरू करें।

### Gemini CLI

```sh
gemini extensions install https://github.com/LenoSeibert/semver-plugin
```

Gemini सत्र पुनः आरंभ करें। स्थानीय clone से विकास के लिए
`gemini extensions link .` चलाएँ।

### GitHub Copilot CLI

```sh
copilot plugin install LenoSeibert/semver-plugin
```

### OpenCode और Cursor

ये परिवेश परियोजना में `AGENTS.md` खोजते हैं। repository clone करें और मौजूदा
निर्देशों को बदले बिना फ़ाइल को copy या link करें:

```sh
git clone https://github.com/LenoSeibert/semver-plugin.git
cp semver-plugin/AGENTS.md /path/to/project/AGENTS.md
```

यदि परियोजना में पहले से `AGENTS.md` है, तो SemVer भाग को मैन्युअल रूप से शामिल करें।

## उपयोग

स्थापना के बाद, आज़माएँ:

- “इन परिवर्तनों के बाद अगला संस्करण क्या होना चाहिए?”
- “इस diff की SemVer के अनुसार समीक्षा करें।”
- “इन pre-release वाले संस्करणों को क्रम में लगाएँ।”

प्लगइन SemVer 2.0.0 का पालन करता है। npm, Cargo, PEP 440 या अन्य ecosystem के
नियम केवल स्पष्ट रूप से अनुरोध किए जाने पर लागू होते हैं।

## लाइसेंस और श्रेय

प्लगइन का मूल code और documentation [MIT License](../LICENSE) के अंतर्गत है। यहाँ
शामिल या अनुकूलित Semantic Versioning 2.0.0 नियम Tom Preston-Werner को श्रेय देते हैं
और [CC BY 3.0](../LICENSES/CC-BY-3.0.txt) के अंतर्गत हैं। आवश्यक श्रेय और स्रोत लिंक
के लिए [NOTICE](../NOTICE) देखें।
