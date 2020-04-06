# Kosa's API for the Pariyatti Mobile App #

The mobile app prototype will need to consume Kosa APIs. Get the development version running, below. 
We will list API endpoints here as they become available. The goal will be to make the API endpoints very 
simple and reflective of the Pariyatti mobile app wireframes.

## Open Questions ##

- "Resources" is overloaded with web terminology. "Assets" instead?
- DB+API: UUID or Integer ids?
- URLs: Diacritics:
  - note the "Pali Word of the Day" example
  - I don't think we should use diacritics in URLs; we can substitute their standard ASCII representations
  - diacritics in json is fine
- URLs: do we want semantic URLs over documents? - I would argue yes:
  - the documents might have very hetergenous structures
  - there shouldn't be so many resource types that routes become overwhelming
  - ex. `/api/resources/audiobooks` vs `/api/resources` + "type":"audiobook"
- Cards: should we structure dohas as cards or not?
- Cards: "CTA" (Call to Action) or just "button"?
- Cards: is a "generic" card a supertype of all other Cards? (I vote no; many fields ignored)

## Stubbed ##

```
None - we'll try to implement real APIs over neo4j now but we might stub APIs if it helps the mobile team.
```

## Implemented ##

```
http://localhost:3000/api/today.json
http://localhost:3000/api/topics.json
```

## Planned (Examples) ##

### High Level APIs ###

```
/api/today

=> {"today_cards": [Card, Card, Card, ... ]}
```

### Resources ###

```
/api/resources/audiobook/1

=> {"id": 123, "title": "content-type": "audio/mpeg", "language": "en", 
    "Curbing Anger, Spreading Love", "author": "Bhikkhu Visuddhacara", "url": "https://pariyatti.org/anger.mp3"}

/api/resources/book/1

=> {"id": 123, "language": "en", 
    "title": "The Elimination of Anger", "author": "Ven. K. Piyatissa Thera", "url": "https://store.pariyatti.org/Anger"}
```

### User Objects ###

```
/api/cards/1

# Card interface:
=> {"id": 123, "type": "", 
    "flag": "news",
    "title": "Used to override default card titles",
    "cta_caption": "Click me!",
    "cta_url": "https://pariyatti.org/target_page",
    "bookmarkable": true,
    "shareable": false,
    }

=> {"id": 123, "type": "generic",  
    "title": "Stay Updated", 
    "header": "Sign up for the Pariyatti newsletter", 
    "image": "https://pariyatti.org/newsletter.png",
    "text": "We'll keep you updated with the latest news and updates."}

=> {"id": 123, "type": "words_of_the_buddha",  
    "sutta_reference": "Dhammapada 17.223", 
    "pali": "Akkodhena jine kodhaṃ;\nasādhuṃ sādhunā jine;\njine kadariyaṃ dānena;\nsaccenālikavādinaṃ.", 
    "translation_language": "en",
    "translation": "Overcome the angry by non-anger;\novercome the wicked by goodness;\novercome the miser by generosity;\novercome the liar by truth."
    "audio_url": "http://download.pariyatti.org/dwob/dhammapada_17_223.mp3"}

=> {"id": 123, "type": "pali_word_of_the_day",  
    "pali": "vipassisuṃ", 
    "translation_language": "en",
    "translation": "insight"
    "audio_url": "http://download.pariyatti.org/pali/vipassisu.m.mp3"}

=> {"id": 123, "type": "doha",
    "TODO": "TODO"}

=> {"id": 123, "type": "inspiration", "alignment": "stacked", 
    "image": "https://pariyatti.org/webu.jpg", "quote": "Ven. Webu Sayadaw was one of the most highly respected monks of the last century in Burma."}

=> {"id": 123, "type": "inspiration", "alignment": "overlay", 
    "image": "https://pariyatti.org/buddha.jpg", "quote": "Ataapi Sampajaanno Satima"}

=> {"id": 123, "type": "topic_of_the_week", "alignment": "list", 
    "header": "When anger puts you down", "rows": [Audiobook, Book, ... ]}

    # See Resources for `Audiobook` and `Book` examples

=> {"id": 123, "type": "donation", 
    "icon": "https://pariyatti.org/heart-money-icon.png", 
    "header": "We are running a donation camp", "text": "We are generating funds for the upcoming pilgrimage to Nepal and India."}

=> {"id": 123, "type": "pilgrimage", 
    "header": "Along the Path - India &amp; Nepal", "text": "&quot;There are four places which should be (visited and) seen by a person of devotion,&quot; the Buddha said."}

=> {"id": 123, "type": "recommended_read", 
    "header": "Letters From the Dhamma Brothers",
    "image": "https://pariyatti.org/dhamma-brothers-cover.png", 
    "author": "Joey Phillips",
    "category": "Softcover Book",
    "page_count": 112
    "text": "As we know all too well, anger causes unhappiness to ourselves and to others. If we could only live with less anger and more love..."}

```

### Enums ###

These are just easier to list with a schema snippet than an example.

```
# Card type: { "type": { "enum": [ "generic",
                                    "words_of_the_buddha",
                                    "pali_word_of_the_day", 
                                    "doha", 
                                    "inspriation", 
                                    "topic_of_the_week", 
                                    "donation", 
                                    "pilgrimage", 
                                    "recommended_read" ] } }
# Inspiration alignment: { "alignment": {"enum": [ "stacked", "overlay" ]}}
# Topic of the Week alignment: { "alignment": {"enum": [ "list", "blurb" ]}}
```
