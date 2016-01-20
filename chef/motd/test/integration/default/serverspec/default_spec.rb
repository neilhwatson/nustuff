require 'spec_helper'

describe 'motd::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  
  describe file( '/etc/motd' ) do
     it { should be_file }
     it { should be_mode 644 }
     it { should be_owned_by 'root' }
     it { should be_grouped_into 'root' }
     its(:content) { should match /Neil H\. Watson/ }
  end
end
