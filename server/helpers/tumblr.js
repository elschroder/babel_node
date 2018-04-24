/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * DS103: Rewrite code to no longer use __guard__
 * DS207: Consider shorter variations of null checks
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
let prettyPrintPost;
const _ = require('lodash');
const _s = require('underscore.string');
const Moment = require('moment-timezone');
// const LanguageId = require('../helpers/language');

const setTitle = function (post) {
  if ((post.type === 'photo') || (post.type === 'video')) { // if a post is of the type photo we need to create a title.
    let { caption } = post;
    // console.log "===== setTitle ", post.caption
    caption = caption.replace(/\n/g, ' ');
    caption = caption.replace(/\s\s+/g, ' '); // removes any extra space
    const splitCaption = /\<h2\>(.*?)\<\/h2\>/i.exec(caption);
    post.title = __guard__(splitCaption != null ? splitCaption[1] : undefined, x => x.replace(/<(.|\n)*?>/g, ''));
    return post.caption = caption.replace(splitCaption != null ? splitCaption[0] : undefined, '');
  }
};

const setScaledImages = function (post) { // picks a smaller image and all tumblr links are redirected to https (the api does not allow this by default)
  const images = post.photos;
  if (images) {
    return _.each(images, (image) => {
      image.picked_size = _.find(image.alt_sizes, { width: 400 });
      if (image.original_size) {
        image.original_size.url = image.original_size != null ? image.original_size.url.replace(/http\:/, 'https:') : undefined;
      }
      if (image.picked_size) {
        return image.picked_size.url = image.picked_size != null ? image.picked_size.url.replace(/http\:/, 'https:') : undefined;
      }
      return image.picked_size = image.original_size;
    });
  }
};

const setSummary = function (post, language) {
  if (post.caption) { post.caption_summary = _s.prune(post.caption, 1000); }
  if (post.caption_summary) { post.caption_summary = post.caption_summary.replace(/\.\.\.$/, ` <a href='/${language}/n/${post.id}'>[+]</a></b></i></p>`); } // extra </b></i></p> are result of a work-around to circunvent the missing closing tags when the text is truncated. scripts to find them where quite heavy.
  if (post.body) { post.body_summary = _s.prune(post.body, 1000); }
  if (post.body_summary) { post.body_summary = post.body_summary.replace(/\.\.\.$/, ` <a href='/${language}/n/${post.id}'>[+]</a></b></i></p>`); } // extra </b></i></p> are result of a work-around to circunvent the missing closing tags when the text is truncated. scripts to find them where quite heavy.
  return post;
};

const setDate = function (post, language) {
  if (language === 'cat') { language = 'ca'; }
  return post.date = Moment(post.timestamp, 'X').tz('Europe/Madrid').locale(`${language}`).format('LL');
};

const setType = function (post) {
  if (post.type === 'text') { post.isText = true; }
  if (post.type === 'photo') { post.isPhoto = true; }
  if (post.type === 'video') { post.isVideo = true; }
  if (post.type === 'link') { post.isLink = true; }
  return post;
};

const setLanguage = function (post, language) {
  post.language = language;
  return post;
};

module.exports.prettyPrintPost = (prettyPrintPost = function (post, language) {
  setLanguage(post, language);
  setType(post);
  setTitle(post);
  setScaledImages(post);
  setSummary(post, language);
  setDate(post, language);

  return post;
});

function __guard__(value, transform) {
  return (typeof value !== 'undefined' && value !== null) ? transform(value) : undefined;
}
