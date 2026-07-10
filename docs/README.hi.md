# SemVer नियम

[![License: MIT](https://img.shields.io/badge/%E0%A4%B2%E0%A4%BE%E0%A4%87%E0%A4%B8%E0%A5%87%E0%A4%82%E0%A4%B8-MIT-yellow.svg)](../LICENSE) [![SemVer](https://img.shields.io/badge/SemVer-2.0.0-blue.svg)](https://semver.org/) [![CC BY 3.0](https://img.shields.io/badge/%E0%A4%A8%E0%A4%BF%E0%A4%AF%E0%A4%AE-CC%20BY%203.0-lightgrey.svg)](../LICENSES/CC-BY-3.0.txt)

![तीन जुड़े हुए संस्करण मील के पत्थरों का अमूर्त चित्रण](../assets/semver-rules-hero.png)

> कोडिंग एजेंटों के लिए यह पोर्टेबल प्लगइन रिलीज़ की योजना और समीक्षा करते समय
> आधिकारिक [Semantic Versioning 2.0.0](https://semver.org/) विनिर्देशन लागू करता है।

[🇺🇸 English](../README.md) · [🇨🇳 中文（简体）](README.zh-CN.md) · [🇪🇸 Español](README.es.md) · [🇧🇷 Português (Brasil)](README.pt-BR.md)

---

## 📋 विषय-सूची

- [उपयोग का मामला और हल की जाने वाली समस्या](#-उपयोग-का-मामला-और-हल-की-जाने-वाली-समस्या)
- [सुविधाएँ](#-सुविधाएँ)
- [समर्थित परिवेश](#-समर्थित-परिवेश)
- [स्थापना](#-स्थापना)
- [उपयोग](#-उपयोग)
- [प्रोजेक्ट ऑटोमेशन](#-प्रोजेक्ट-ऑटोमेशन)
- [लाइसेंस और श्रेय](#-लाइसेंस-और-श्रेय)

---

## 🎯 उपयोग का मामला और हल की जाने वाली समस्या

इस plugin का उपयोग तब करें जब किसी agent को तय करना हो कि परिवर्तनों के समूह से
`major`, `minor`, `patch` या कोई release नहीं बननी चाहिए, खासकर release planning,
pull request review, changelog तैयारी या version audit के दौरान।

यह release से जुड़ी एक आम समस्या हल करता है: version bump अक्सर commit labels,
अनुमान या diff के आकार के आधार पर चुन लिया जाता है। SemVer इसके बजाय घोषित
public API और compatibility impact पर निर्भर करता है। यह plugin agent के सामने
यही नियम बनाए रखता है, वास्तविक परिवर्तनों की जाँच में मदद करता है और release
recommendation को समझाना आसान बनाता है।

---

## ✨ सुविधाएँ

| Skill | विवरण |
| --- | --- |
| `semver` | अगला संस्करण चुनता है और संस्करण की संरचना तथा प्राथमिकता जाँचता है |
| `semver-review` | परिवर्तनों की समीक्षा करता है और `major`, `minor`, `patch`, या कोई रिलीज़ नहीं, की सिफारिश करता है |
| Hooks | सत्र और सब-एजेंट शुरू होने पर hooks नियमों का संक्षिप्त स्मरण लोड करते हैं; होस्ट के Node.js के अतिरिक्त किसी बाहरी निर्भरता की आवश्यकता नहीं है |

---

## 🔌 समर्थित परिवेश

| परिवेश | एकीकरण |
| --- | --- |
| **Codex** | manifest, skills और hooks |
| **Claude Code** | manifest, skills और hooks |
| **Gemini CLI** | extension, context, skills और session hook |
| **GitHub Copilot CLI** | plugin, skills और hooks |
| **OpenCode / Cursor** | `AGENTS.md` द्वारा पोर्टेबल निर्देश |

---

## 📦 स्थापना

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

marketplace के माध्यम से install करना भविष्य के लिए compatible रास्ता है।
repository से direct install अभी काम करता है, लेकिन Copilot चेतावनी देता है
कि यह तरीका deprecated है:

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

> **💡 सुझाव:** यदि परियोजना में पहले से `AGENTS.md` है, तो SemVer भाग को
> मैन्युअल रूप से शामिल करें।

---

## 🚀 उपयोग

स्थापना के बाद, आज़माएँ:

- *"इन परिवर्तनों के बाद अगला संस्करण क्या होना चाहिए?"*
- *"इस diff की SemVer के अनुसार समीक्षा करें।"*
- *"इन pre-release वाले संस्करणों को क्रम में लगाएँ।"*

> **ℹ️ ध्यान दें:** प्लगइन SemVer 2.0.0 का पालन करता है। npm, Cargo, PEP 440
> या अन्य ecosystem के नियम केवल स्पष्ट रूप से अनुरोध किए जाने पर लागू होते हैं।

---

## 🤖 प्रोजेक्ट ऑटोमेशन

यह repository release version को [`VERSION`](../VERSION) में रखती है। वही
version Codex, Claude Code और GitHub Copilot plugin manifests में भी होना चाहिए।
CI pull requests और `main` या `dev` पर pushes के दौरान
`node scripts/check-version.js` चलाता है।

जब `dev` बदलती है, promotion workflow version validate करता है और `dev` से
`main` तक pull request खोलने के लिए compare link दिखाता है। यह pull requests
अपने-आप create या merge नहीं करता।

जब `main` बदलती है, release workflow version validate करता है, GitHub tag
`vX.Y.Z` बनाता है, `semver-plugin-X.Y.Z.zip` generate करता है और GitHub Release
publish करता है। `VERSION` strict SemVer ही रहता है, शुरुआत में `v` नहीं होता।

---

## 📄 लाइसेंस और श्रेय

प्लगइन का मूल code और documentation [MIT License](../LICENSE) के अंतर्गत है। यहाँ
शामिल या अनुकूलित Semantic Versioning 2.0.0 नियम Tom Preston-Werner को श्रेय देते हैं
और [CC BY 3.0](../LICENSES/CC-BY-3.0.txt) के अंतर्गत हैं। आवश्यक श्रेय और स्रोत लिंक
के लिए [NOTICE](../NOTICE) देखें।
