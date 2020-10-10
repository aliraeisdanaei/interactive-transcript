class Episode
  extend Memoist
  include ErrorHandling

  attr_reader :node, :feed

  def initialize(node, feed)
    @node = node
    @feed = feed
  end

  memoize def slug
    url = node.css('link').text
    url[%r{^https://www.patreon.com/posts/(.*)$}, 1] || raise("Cannot find slug in #{url}")
  end

  def number
    slug[/^\d+/]&.to_i
  end

  def title
    node.css('title').first.text
  end

  def description_html
    node.css('description').text
  end

  memoize def description
    EpisodeDescription.new(description_html, self)
  end

  delegate :notes_html, :chapters, :processed_html, :pretty_html, :access_key, :vocab_url, :vocab, to: :description

  memoize def record
    EpisodeRecord.find_by(access_key: access_key) || EpisodeRecord.find_by(slug: slug)
  end

  memoize def transcript_editor_html
    if Rails.env.development?
      episode_path = Rails.root.join("data", "episodes", slug)
      path = episode_path.join("transcript_editor.html")
      return File.read(path) if File.exists?(path)
    end

    hide_and_report_errors do
      file_contents = DropboxAdapter.new.transcript_for(number)
      doc = Nokogiri::HTML(file_contents)
      doc.css('#transcript').to_html
    end
  end

  memoize def timed_script
    hide_and_report_errors do
      TimedScript.new(transcript_editor_html) if transcript_editor_html
    end
  end

  def audio_url
    node.css('enclosure').first["url"]
  end

  memoize def audio
    Audio.new(audio_url)
  end

  def paragraphs
    chapters.flat_map(&:paragraphs)
  end

  memoize def processed
    ::Processed::Episode.new(
      title: title,
      cover_url: feed.cover_url,
      audio_url: audio_url,
      notes_html: notes_html,
      chapters: chapters&.map(&:processed),
      audio_chapters: processed_audio_chapters,
    )
  end

  def processed_audio_chapters
    return nil if chapters.nil? # No transcript, e.g. Zwischending

    audio.chapters.to_enum.with_index.map { |chapter, index|
      if chapter.picture.present?
        local_path = Rails.root.join('public', 'episodes', access_key, 'chapters', chapter.id, 'picture.jpg')
        FileUtils.mkdir_p(File.dirname(local_path))
        File.open(local_path, 'wb') { |f| f.write(chapter.picture.data) }
      end
      ::Processed::AudioChapter.new(
        id: chapter.id,
        start_time: chapter.start_time / 1000,
        end_time: chapter.end_time / 1000,
        has_picture: chapter.picture.present?,
      )
    }
  end
end
