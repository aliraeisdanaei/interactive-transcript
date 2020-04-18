$(document).ready(() => {
  const media = document.querySelector('audio');
  const timestampElements = $('.timestamp').toArray().map((x) => [parseInt(x.dataset['timestamp']), x])
  let activeTimestamp = null;

  function timeupdate(e) {
    const eventTs = media.currentTime;
    const item = timestampElements.find(([t1, e], index) => {
      const nextPair = timestampElements[index + 1];
      const t2 = nextPair ? nextPair[0] : null;
      return eventTs >= t1 && (!t2 || eventTs < t2);
    })
    if (item) {
      const [ts, e] = item;
      const elem = $(e).parent();
      if (ts !== activeTimestamp) {
        if (elem.height() > $('#content').height()) {
          elem.get(0).scrollIntoView({ behavior: 'smooth', block: 'start' });
        }
        else {
          elem.get(0).scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
        $(".current").removeClass("current");
        $(elem).addClass("current");
        activeTimestamp = ts;
      }
    }
    else {
      $(".current").removeClass("current");
      activeTimestamp = null;
    }
  }
  media.addEventListener('timeupdate', timeupdate);

  $('.timestamp').parent().addClass('timestampedEntry')
  $('.timestamp').parent().click(function(event) {
    let timestamp = $(event.target).find('.timestamp');
    if (timestamp.length) {
      media.currentTime = parseInt(timestamp.data('timestamp'));
      media.play();
    }
  });

  $(window).keypress(function(event) {
    switch (event.key) {
      case " ":
        if (media.paused) {
          media.play();
        }
        else {
          media.pause();
        }
        event.preventDefault();
        break;
    }
  });
  $(window).keydown(function(event) {
    const ev = event.originalEvent;
    let e;
    switch (ev.keyCode) {
      case 37: // left
        media.currentTime -= ev.shiftKey ? 20 : 5;
        event.preventDefault();
        break;
      case 39: // right
        media.currentTime += ev.shiftKey ? 20 : 5;
        event.preventDefault();
        break;
      case 38: // up
        e = $('.current').prevAll('.timestampedEntry').get(0);
        if (e) {
          media.currentTime = parseInt($(e).find('.timestamp').data('timestamp'))
          event.preventDefault();
        }
        break;
      case 40: // down
        e = $('.current').nextAll('.timestampedEntry').get(0);
          if (e) {
          media.currentTime = parseInt($(e).find('.timestamp').data('timestamp'))
          event.preventDefault();
        }
        break;
    }
  });

  $('.timestampedEntry').append($('<button>').addClass("translateButton").text("Translate"))

  $('.translateButton').click(function(event) {
    event.preventDefault();
    event.stopPropagation();
    let $button = $(event.target);
    $button.html("Translating...");
    $button.attr("disabled", "disabled");
    $.ajax({
      url: "/translate.json",
      method: 'post',
      data: {
        key: $button.parent().data('translationId')
      }
    }).done(function(resp) {
      $button.replaceWith($('<p>').addClass('translation').text(resp.text))
    });
  })
});
