import UIKit

class DrawingView: UIView {

    private var lines: [[CGPoint]] = [] // Массив для хранения всех линий
    private var currentLine: [CGPoint] = []

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self)
        
        currentLine = [point]
        setNeedsDisplay()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self)
        
        currentLine.append(point)
        setNeedsDisplay()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(currentLine) // Сохраняем линию
        currentLine.removeAll() // Очищаем текущую линию
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setLineWidth(5)
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineCap(.round)

        // Рисуем все сохраненные линии
        for line in lines {
            drawLine(line, in: context)
        }
        
        // Рисуем текущую линию (если есть)
        drawLine(currentLine, in: context)
        
        context.strokePath()
    }

    private func drawLine(_ line: [CGPoint], in context: CGContext) {
        guard let firstPoint = line.first else { return }
        context.beginPath()
        context.move(to: firstPoint)
        for point in line.dropFirst() {
            context.addLine(to: point)
        }
    }
}
