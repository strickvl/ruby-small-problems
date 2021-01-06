class InvalidCodonError < StandardError
end

class Translation
  GLOSSARY = {
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UGG" => "Tryptophan",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  def self.of_rna(strand)
    input = strand.scan(/[A-Z]{3}/)
    output = []
    input.each do |codon|
      break if Translation.of_codon(codon) == "STOP"
      output << Translation.of_codon(codon)
    end
    output
  end

  def self.of_codon(codon)
    GLOSSARY.fetch(codon) { raise InvalidCodonError }
  end
end
