require "rails_helper"

describe TimedScript do
  let(:transcript_editor_html) {
    <<~HTML
    <div id="transcript" class="transcript-base" contenteditable="false">

    <h2 id="chapter">Intro</h2>
    <b data-spk="0" title="">Cari:</b><br>
    <small style="opacity: 0.5;">[0:15]</small> <span data-start="00:00:14.924" data-end="00:00:16.134" data-spk="0" data-label="Cari"><span title="0:15" style="background-color: white; background-position: initial initial; background-repeat: initial initial;">Hallo!</span></span><br>
    <br>
    <b data-spk="1" title="">Manuel:</b><br>
    <small style="opacity: 0.5;">[0:16]</small> <span data-start="00:00:16.464" data-end="00:00:17.434" data-spk="1" data-label="Manuel"><span title="0:16" style="background-color: white; background-position: initial initial; background-repeat: initial initial;">Hallo</span>&nbsp;<span style="background-color: rgb(255, 255, 255);">Cari!</span></span><br>
    <br>
    <b data-spk="0" title="">Cari:</b><br>
    <small style="opacity: 0.5;">[0:20]</small>&nbsp;Ich hab heute m<span data-start="00:00:19.704" data-end="00:00:21.334" data-spk="0" data-label="Cari"><span title="0:20" style="background-color: white; background-position: initial initial; background-repeat: initial initial;">al</span> <span title="0:20" style="background-color: white; background-position: initial initial; background-repeat: initial initial;">nicht</span> <span title="0:20" style="background-color: white; background-position: initial initial; background-repeat: initial initial;">mitgesungen.</span></span><br>
    <br>
    <b data-spk="1" title="">Manuel:</b><br>
    <small style="opacity: 0.5;">[0:22]</small>&nbsp;Ja, i<span data-start="00:00:21.864" data-end="00:00:23.874" data-spk="1" data-label="Manuel"><span title="0:22" style="background-color: white; background-position: initial initial; background-repeat: initial initial;">ch</span> <span title="0:22" style="background-color: white; background-position: initial initial; background-repeat: initial initial;">hab</span><span title="0:22" style="background-color: white; background-position: initial initial; background-repeat: initial initial;">&nbsp;schon</span>&nbsp;<span title="0:23" style="background-color: white; background-position: initial initial; background-repeat: initial initial;">mich</span>&nbsp;<span style="background-color: rgb(255, 255, 255);">ein bisschen gewundert.</span></span><br>
    <br>

    HTML
  }
  subject(:instance) { described_class.new(transcript_editor_html) }

  it "breaks it down into paragraphs and timestamped segments" do
    expect(subject.paragraphs[0].speaker.name).to eq "Cari"
    expect(subject.paragraphs[0].text).to eq "Hallo!"
    expect(subject.paragraphs[0].timestamp.to_s).to eq "0:15"
    expect(subject.paragraphs[0].segments[0].text).to eq "Hallo!"

    expect(subject.paragraphs[3].segments[0].text).to eq "Ja, "
    expect(subject.paragraphs[3].segments[1].text).to eq "ich "

  end
end
