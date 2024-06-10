# frozen_string_literal: true

module Events
  module Processors
    module Applications
      class Note < Base
        def process
          application.notes.create(content: params[:content])
        end
      end
    end
  end
end
