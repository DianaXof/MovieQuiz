import UIKit

final class MovieQuizViewController: UIViewController {
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    @IBOutlet private var previewImageView: UIImageView!
    @IBOutlet private var questionIndexLabel: UILabel!
    @IBOutlet private var questionLabel: UILabel!
    
    var currentQuestion: QuizQuestion?
    
    private var currentQuestionIndex = 0
    private var correctAnswer = 0
    private var questions: [QuizQuestion] = []
    
    struct QuizQuestion {
        let image: String
        let text: String
        let correctAnswer: Bool
    }
    
    struct QuizStepViewModel {
        let image: UIImage
        let question: String
        let questionNumber: String
    }
    
    struct QuizResultViewModel {
        let title: String
        let text: String
        let buttonText: String
    }
    
    struct ViewModel {
        let image: UIImage
        let question: String
        let questionNumber: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupQuestionList()
        setupPreviewImageView()
        showQuiz()
    }
    
    private func setupPreviewImageView() {
        previewImageView.layer.masksToBounds = true
        previewImageView.layer.borderWidth = 8
        previewImageView.layer.borderColor = UIColor.white.cgColor
        previewImageView.layer.cornerRadius = 6
    }
    
    private func showResultAlert() {
        let viewModel = QuizResultViewModel(
            title: "Раунд окончен!",
            text: "Ваш результат: \(correctAnswer)/10",
            buttonText: "Сыграть еще раз")
        
        let alert = UIAlertController(
            title: viewModel.title,
            message: viewModel.text,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: viewModel.buttonText, style: .default) { _ in
            self.currentQuestionIndex = 0
            self.correctAnswer = 0
            
            self.showQuiz()
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        showAnswerResult(isCorrect: questions[currentQuestionIndex].correctAnswer)
        nextQuestion()
    }
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        showAnswerResult(isCorrect: questions[currentQuestionIndex].correctAnswer == false)
        nextQuestion()
    }
    
    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
            correctAnswer += 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let colorAnimation = CABasicAnimation(keyPath: "borderColor")
            colorAnimation.fromValue = UIColor.ypWhite1.cgColor
            colorAnimation.toValue = isCorrect ? UIColor.ypGreen1.cgColor : UIColor.ypRed1.cgColor
            colorAnimation.duration = 0.9
            colorAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            
            self.previewImageView?.layer.add(colorAnimation, forKey: "borderColorChange")
            self.previewImageView?.layer.borderColor = UIColor.ypWhite1.cgColor
        }
    }
    
    private func nextQuestion() {
        if currentQuestionIndex == questions.count - 1 {
            showResultAlert()
        } else {
            currentQuestionIndex += 1
            showQuiz()
        }
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)")
        return questionStep
    }
    
    private func showQuiz() {
        let viewModel = convert(model: questions[currentQuestionIndex])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (currentQuestionIndex == 0 ? 0 : 0.6)) {
            UIView.animate(withDuration: self.currentQuestionIndex == 0 ? 0 : 0.4) {
                self.previewImageView?.alpha = 0
                self.questionLabel.alpha = 0
                self.questionIndexLabel.alpha = 0
            } completion: { _ in
                self.previewImageView?.image = viewModel.image
                self.questionLabel.text = viewModel.question
                self.questionIndexLabel.text = viewModel.questionNumber
                
                UIView.animate(withDuration: 0.4) {
                    self.previewImageView?.alpha = 1
                    self.questionLabel.alpha = 1
                    self.questionIndexLabel.alpha = 1
                    
                }
            }
        }
    }
    
    private func setupQuestionList() {
        questions = [
            QuizQuestion(
                image: "The Godfather",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true),
            QuizQuestion(
                image: "The Dark Knight",
                text: "Рейтинг этого фильма больше чем 7?",
                correctAnswer: true),
            QuizQuestion(
                image: "Kill Bill",
                text: "Рейтинг этого фильма больше чем 5?",
                correctAnswer: true),
            QuizQuestion(
                image: "The Avengers",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true),
            QuizQuestion(
                image: "Deadpool",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true),
            QuizQuestion(
                image: "The Green Knight",
                text: "Рейтинг этого фильма больше чем 5?",
                correctAnswer: true),
            QuizQuestion(
                image: "Old",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: false),
            QuizQuestion(
                image: "The Ice Age Adventures of Buck Wild",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: false),
            QuizQuestion(
                image: "Tesla",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: false),
            QuizQuestion(
                image: "Vivarium",
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: false)
        ]
    }
}


/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 */
