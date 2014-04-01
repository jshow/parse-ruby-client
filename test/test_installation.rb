require 'helper'

class TestInstallationObject < Parse::Installation
end

class TestInstallation < ParseTestCase

  def test_new
    VCR.use_cassette('test_new_installation', :record => :new_episodes) do
      tmo = TestInstallationObject.new
      assert_equal tmo.new?, true
      tmo.save
      assert_equal tmo.new?, false
    end
  end

  def test_save
    VCR.use_cassette('test_new_installation', :record => :new_episodes) do
      tmo = TestInstallationObject.new
      installation = TestInstallationObject.new
      installation.device_type = 'ios'
      installation.device_token = 'yaba_daba_do'
      installation.channels = ['bambam', 'joe rockhead']
      installation.save

      assert_equal installation.new?, false
    end
  end

  def test_get
    VCR.use_cassette('test_get_installation', :record => :new_episodes) do
      installation = TestInstallationObject.new
      installation.device_type = 'ios'
      installation.device_token = 'yaba_daba_do'
      installation.channels = ['bambam', 'joe rockhead']
      installation.save

      i = TestInstallationObject.get(installation.id)

      assert_equal i.id, installation.id
      assert_equal i["device_type"], installation["device_type"]
      assert_equal i["device_token"], installation["device_token"]
      assert_equal i["channels"], installation["channels"]            
    end
  end

  def test_delete
    VCR.use_cassette('test_get_installation', :record => :new_episodes) do
      installation = TestInstallationObject.new
      installation.device_type = 'ios'
      installation.device_token = 'yaba_daba_do'
      installation.channels = ['bambam', 'joe rockhead']
      installation.save

      i = TestInstallationObject.get(installation.id)

      assert_equal i.id, installation.id
      assert_equal i["device_type"], installation["device_type"]
      assert_equal i["device_token"], installation["device_token"]
      assert_equal i["channels"], installation["channels"]

      TestInstallationObject.delete(installation.id)

      i = TestInstallationObject.get(installation.id)

      assert_equal i.id, nil
      assert_equal i["device_type"], nil
      assert_equal i["device_token"], nil
      assert_equal i["channels"], nil
    end
  end
end
