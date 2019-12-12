import Markdown2Tweets from '../../app/javascript/markdown2tweets.js'
import data from './data/markdown2tweets/normal.json'
import dataWithFragment from './data/markdown2tweets/with_fragment.json'
import dataNull from './data/markdown2tweets/null.json'

test('load json file data', () => {
  const text = data.text
  const tweets = data.tweets
  const lists = data.list

  expect(text).not.toBe(null)
  expect(tweets).not.toBe(null)
  expect(lists).not.toBe(null)
})

test('Convert text to tweet', () => {
  const text = data.text
  const tweets = data.tweets
  var m2t = new Markdown2Tweets(text, tweets)

  var lists = m2t.lists()
  var list
  for (list of lists) { delete (list.id_str) }
  for (list of data.lists) { delete (list.id_str) }

  expect(JSON.stringify(lists)).toBe(JSON.stringify(data.lists))
})

test('When there is fragment data in text, convert it to tweet', () => {
  const data = dataWithFragment
  const text = data.text
  const tweets = data.tweets
  var m2t = new Markdown2Tweets(text, tweets)

  var lists = m2t.lists()
  var list
  for (list of lists) { delete (list.id_str) }
  for (list of data.lists) { delete (list.id_str) }

  expect(JSON.stringify(lists)).toBe(JSON.stringify(data.lists))
})

test('If the data is null, return null', () => {
  const data = dataNull
  const text = data.text
  const tweets = data.tweets
  var m2t = new Markdown2Tweets(text, tweets)

  var lists = m2t.lists()
  var list
  for (list of lists) { delete (list.id_str) }
  for (list of data.lists) { delete (list.id_str) }

  expect(JSON.stringify(lists)).toBe(JSON.stringify(data.lists))
})