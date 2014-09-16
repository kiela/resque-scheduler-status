module Resque
  module Plugins
    module SchedulerStatus

      VERSION = '0.0.1'

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods

        def create(options = {})
          self.enqueue(self, options)
        end

        def enqueue(klass, options = {})
          uuid = Resque::Plugins::Status::Hash.generate_uuid
          self.enqueue_to(Resque.queue_from_class(klass) || queue, klass, uuid, options)
        end

        def enqueue_to(queue, klass, uuid, options = {})
          Resque::Plugins::Status::Hash.create uuid, :options => options

          if Resque.enqueue_to(queue, klass, uuid, options)
            uuid
          else
            Resque::Plugins::Status::Hash.remove(uuid)
            nil
          end
        end

        def create_in(number_of_seconds_from_now, options = {})
          self.enqueue_in(number_of_seconds_from_now, self, options)
        end

        def create_at(timestamp, options = {})
          self.enqueue_at(timestamp, self, options)
        end

        def enqueue_in(number_of_seconds_from_now, klass, options = ())
          self.enqueue_at(Time.now + number_of_seconds_from_now, klass, options)
        end

        def enqueue_at(timestamp, klass, options = {})
          uuid = Resque::Plugins::Status::Hash.generate_uuid
          self.enqueue_at_with_queue(Resque.queue_from_class(klass), timestamp, klass, uuid, options)
        end

        def enqueue_at_with_queue(queue, timestamp, klass, uuid, options = {})
          Resque::Plugins::Status::Hash.create uuid, options: options

          if Resque.enqueue_at_with_queue(queue, timestamp, klass, uuid, options)
            uuid
          else
            Resque::Plugins::Status::Hash.remove(uuid)
            nil
          end
        end
      end

      def scheduled(queue, klass, *args)
        uuid, options = args
        self.enqueue_to(queue, self, uuid, options)
      end
    end
  end
end
