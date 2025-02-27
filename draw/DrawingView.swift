import UIKit

class DrawingView: UIView {

    var lines: [(color: UIColor, points: [CGPoint])] = [] // Храним линии с цветами
    private var currentLine: [CGPoint] = []
    var currentColor: UIColor = .red // Цвет по умолчанию

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
        lines.append((color: currentColor, points: currentLine)) // Сохраняем линию с цветом
        currentLine.removeAll()
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setLineWidth(5)
        context.setLineCap(.round)

        // Рисуем все сохраненные линии с их цветами
        for (color, line) in lines {
            context.setStrokeColor(color.cgColor)
            drawLine(line, in: context)
        }
        
        // Рисуем текущую линию (если есть)
        context.setStrokeColor(currentColor.cgColor)
        drawLine(currentLine, in: context)
    }

    private func drawLine(_ line: [CGPoint], in context: CGContext) {
        guard let firstPoint = line.first else { return }
        context.beginPath()
        context.move(to: firstPoint)
        for point in line.dropFirst() {
            context.addLine(to: point)
        }
        context.strokePath()
    }
    
    func clearDrawing() {
        lines.removeAll()
        currentLine.removeAll()
        setNeedsDisplay()
    }
}
