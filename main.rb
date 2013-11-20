module XmasDraw
  class Matcher
    attr_reader :people, :blacklist

    def initialize(people, blacklist={})
      @people = people
      @blacklist = blacklist
    end

    def match
      begin
        partners = people.shuffle.zip(people.shuffle)
      end until valid(partners)
      partners
    end

    def valid(partners)
      no_selfies(partners) && blacklist_honored(partners)
    end

    def blacklist_honored(partners)
      blacklist.none? do |giver, blacklisted|
        partners.find { |g, r| g==giver && blacklisted.include?(r) }
      end
    end

    def no_selfies(partners)
      partners.none? { |g,r| g == r }
    end
  end
end

def prompt_for_names
  prompt = "Enter a name (leave blank when done)"
  names = []

  loop do
    puts(prompt)
    name = gets.strip
    break if name.empty?
    names << name
  end

  names
end

if $0 == __FILE__
  names = prompt_for_names
  p XmasDraw::Matcher.new(names).match
end
