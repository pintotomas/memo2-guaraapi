require 'spec_helper'

describe JobOffer do
  subject(:job_offer) { described_class.new({}) }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:location) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:owner) }
    it { is_expected.to respond_to(:owner=) }
    it { is_expected.to respond_to(:created_on) }
    it { is_expected.to respond_to(:updated_on) }
    it { is_expected.to respond_to(:is_active) }
    it { is_expected.to respond_to(:required_experience) }
  end

  describe 'valid?' do
    it 'should be invalid when title is blank' do
      job_offer = described_class.new({})
      expect(job_offer).not_to be_valid
      expect(job_offer.errors).to have_key(:title)
    end

    it 'should be valid when title is not blank' do
      job_offer = described_class.new(title: 'a title')
      expect(job_offer).to be_valid
    end

    it 'should be invalid when required experience is not a number' do
      job_offer = described_class.new(title: 'a title', required_experience: 'exp')
      expect(job_offer).not_to be_valid
      expect(job_offer.errors).to have_key(:required_experience)
    end

    it 'should be invalid when required experience is negative' do
      job_offer = described_class.new(title: 'a title', required_experience: -4)
      expect(job_offer).not_to be_valid
      expect(job_offer.errors).to have_key(:required_experience)
    end

    it 'should be invalid when required experience is not an integer' do
      job_offer = described_class.new(title: 'a title', required_experience: 4.5)
      expect(job_offer).not_to be_valid
      expect(job_offer.errors).to have_key(:required_experience)
    end

    it 'should be valid when required experience is 0' do
      job_offer = described_class.new(title: 'a title', required_experience: 0)
      expect(job_offer).to be_valid
    end

    it 'should be valid when required experience is greater than 0' do
      job_offer = described_class.new(title: 'a title', required_experience: 1)
      expect(job_offer).to be_valid
    end
  end
end
