# frozen_string_literal: true

module Api
  module V1
    class QuestionsController < ApplicationController
      before_action :set_question, only: %i[show update destroy]

      # GET /questions
      def index
        @questions = Question.order('created_at DESC')

        render json: @questions
      end

      # GET /questions/1
      def show
        render json: @question
      end

      # POST /questions
      def create
        @question = Question.new(question_params)

        if @question.save
          render json: @question, status: :created, location: api_v1_question_url(@question)
        else
          render_error_message(model: @question, status: :unprocessable_entity)
        end
      end

      # PATCH/PUT /questions/1
      def update
        if @question.update(question_params)
          render json: @question
        else
          render_error_message(model: @question, status: :unprocessable_entity)
        end
      end

      # DELETE /questions/1
      def destroy
        if @question.destroy
          render json: @question
        else
          render_error_message(model: @question, status: :unprocessable_entity)
        end
      end

      private

      def set_question
        id = params[:id]
        @question = if 'sample'.eql? id
                      Question.all.sample
                    else
                      Question.find(id)
                    end
      end

      def question_params
        params.require(:question).permit(:content, :answer_content)
      end
    end
  end
end
