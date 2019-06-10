class ColoquioScoreHasToBePresentAndUniqueError < RuntimeError
end

class ParcialesMustHaveExactlyTwoScores < RuntimeError
end

class TareasMustHaveAtLeastOneScoreError < RuntimeError
end

class ScoreCanNotBeNilError < RuntimeError
end
