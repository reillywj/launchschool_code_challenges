class House
  def self.recite
    recital = ''
    pieces.size.times do |index|
      recital = first_line -1 if index == 0
      recital += stanza index unless index == 0
      recital += ".\n"
    end
    recital
  end

  private_class_method

  def self.this_is(phrase)
    "This is #{phrase}"
  end

  def self.first_line(row)
    this_is pieces[row].first
  end

  def self.stanza(index)
    stanza = "\n"
    (index + 1).times do |number|
      row = piece_row index, number
      case row
      when -1
        stanza += " #{pieces[row][0]}"
      else
        stanza +=   case number
                    when 0
                      first_line row
                    else
                      " #{pieces[row][0]}"
                    end
        stanza += "\n"
        stanza += pieces[row][1].to_s
      end
    end
    stanza
  end

  def self.piece_row(index, increment)
    -1 - index + increment
  end

  def self.pieces
    [
      ['the horse and the hound and the horn', 'that belonged to'],
      ['the farmer sowing his corn', 'that kept'],
      ['the rooster that crowed in the morn', 'that woke'],
      ['the priest all shaven and shorn', 'that married'],
      ['the man all tattered and torn', 'that kissed'],
      ['the maiden all forlorn', 'that milked'],
      ['the cow with the crumpled horn', 'that tossed'],
      ['the dog', 'that worried'],
      ['the cat', 'that killed'],
      ['the rat', 'that ate'],
      ['the malt', 'that lay in'],
      ['the house that Jack built']
    ]
  end
end
