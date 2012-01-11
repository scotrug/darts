module Darts

  module Memory
    class << self
      def store(recording)
        recordings << { 
          :test_type => recording.test_type, 
          :test_location => recording.test_location, 
          :source_files => recording.source_files
        }
      end

      def save
        File.open('.darts', 'w') do |io|
          Marshal.dump(recordings, io)
        end
      end
      
    private
    
      def recordings
        @recordings ||= []
      end
    end

  end
end