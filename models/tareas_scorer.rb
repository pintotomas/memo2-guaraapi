class TareasScorer
  TAREAS_SUBJECT_TYPE_NAME_CONST = 'tareas'.freeze
  MINIMUM_PASS_VALUE_CONST = 6
  MINIMUM_INDIVIDUAL_TASK_VALUE_CONST = 4
  MAXIMUM_FAILED_TASKS_VALUE_CONST = 2
  DEFAULT_FAILED_COURSE_SCORE = 1

  def calculate_final_score(score)
    return FinalScore.new if score.type_subject != TAREAS_SUBJECT_TYPE_NAME_CONST

    TareasScoresValidator.new.validate(score)
    score_sum = 0
    failed_tasks = 0
    score.scores.each do |s|
      score_sum += s
      failed_tasks += 1 if s < MINIMUM_INDIVIDUAL_TASK_VALUE_CONST
    end

    get_final_score(score_sum, failed_tasks, score.scores.length)
  end

  def get_final_score(score_sum, number_of_failed_tasks, number_of_tasks)
    if number_of_failed_tasks >= MAXIMUM_FAILED_TASKS_VALUE_CONST
      return FinalScore.new(score: DEFAULT_FAILED_COURSE_SCORE, passed_course: false)
    end

    final_score = score_sum / number_of_tasks
    FinalScore.new(score: final_score, passed_course: final_score >= MINIMUM_PASS_VALUE_CONST)
  end
end
