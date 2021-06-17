require_relative 'spec_helper'
require_relative '../lib/rule_number'

RSpec.describe ::RuleNumber do
  subject { sorted.reverse.collect { |number| RuleNumber.new(number) }.sort.map(&:to_s) }

  context 'when sorting only integers' do
    let(:sorted) { %w[2 3 4] }

    it { is_expected.to eq sorted }
  end

  context 'when sorting decimals' do
    let(:sorted) { %w[6.1 6.2 6.10] }

    it { is_expected.to eq sorted }

    context 'when there are also parenthetical alphas' do
      let(:sorted) { %w[6.1(a) 6.1(b) 6.1(c)] }

      it { is_expected.to eq sorted }
    end
  end

  context 'when sorting mixed integers and decimals' do
    let(:sorted) { %w[6A 6C 910] }

    it { is_expected.to eq sorted }
  end

  context 'when sorting rule numbers with differing levels' do
    let(:sorted) { %w[6.1 6.1(a) 6.1(a)(i)] }

    it { is_expected.to eq sorted }
  end

  context 'when there are roman numerals' do
    let(:sorted) { %w[6(i) 6(ii) 6(iv) 6(v) 6(vi) 6(ix) 6(x) 6(xiv) 6(xix) 6(xx)] }

    it { is_expected.to eq sorted }
  end

  context 'when there are repeated characters' do
    let(:sorted) { %w[6.1(a) 6.1(b) 6.1(aa) 6.1(bb)] }

    it { is_expected.to eq sorted }
  end

  context 'when there is lots of text' do
    let(:sorted) do
      [
        'NFA Compliance Rule 2-41',
        'NFA Interpretive Notice #9062',
        'NFA Registration Rule 101',
      ]
    end

    it { is_expected.to eq sorted }
  end

  context 'when there are dashes' do
    let(:sorted) do
      [
        'NFA Compliance Rule 2-41',
        'NFA Compliance Rule 2-42',
      ]
    end

    it { is_expected.to eq sorted }
  end

  context 'when there are commas' do
    let(:sorted) { ['One, Too', 'One, Tree'] }

    it { is_expected.to eq sorted }
  end

  context 'when there are pound signs (#)' do
    let(:sorted) do
      [
        'NFA Compliance Rule #2',
        'NFA Compliance Rule #3',
      ]
    end

    it { is_expected.to eq sorted }
  end

  context 'when there are extra spaces' do
    let(:sorted) do
      [
        'NFA Compliance Rule 2-33',
        'NFA Compliance  Rule 2-34',
        'NFA Compliance Rule 2-34(a)'
      ]
    end

    it { is_expected.to eq sorted }
  end

  context 'when there are numbers following text' do
    let(:sorted) do
      [
        'Financial Requirements Section 4.0',
        'Financial Requirements Section 4.1',
        'Financial Requirements Section 7',
        'Financial Requirements Section 13',
        'Financial Requirements Section 13(b)',
        'Financial Requirements Section 15',
      ]
    end

    it { is_expected.to eq sorted }
  end

  context 'when there are many dots' do
    let(:sorted) { %w[506 506.A 506.B 515 515.B 515.B.1 515.B.2 515.B.3 515.C 515.E 523] }

    it { is_expected.to eq sorted }
  end

  context 'when dots, parenthesis and roman numerals are all mixed' do
    let(:sorted) do
      %w[
        49.20(b)(3)
        49.20(b)(4)
        49.20(c)(1)(i)(A)
        49.20(c)(1)(i)(B)
        49.20(c)(1)(i)(C)
        49.20(c)(1)(ii)
        49.20(c)(2)
        49.20(c)(3)
        49.20(c)(4)
        49.20(c)(5)
        49.20(d)
        49.21
        49.21(a)(1)
        49.21(b)(1)
        49.21(b)(2)
        49.21(c)
        49.22(b)(1)
      ]
    end

    it { is_expected.to eq sorted }
  end

  context 'when spaces, parens, numbers, text and romans are mixed' do
    let(:sorted) do
      [
        '17 CFR 1.23(b)',
        '17 CFR 4.23(a)(12)',
        '17 CFR 5.23(b)',
        '17 CFR 31.23(b)',
        '17 CFR 31.23(bb)',
        '17 CFR 31.23(iv)',
        '17 CFR 49.23(b)',
      ]
    end

    it { is_expected.to eq sorted }
  end
end
