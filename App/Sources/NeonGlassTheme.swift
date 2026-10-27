import SwiftUI

public struct NeonGlow: ViewModifier {
    var color: Color
    var radius: CGFloat = 12
    
    public func body(content: Content) -> some View {
        content
            .shadow(color: color.opacity(0.75), radius: radius, x: 0, y: 0)
            .shadow(color: color.opacity(0.4), radius: radius * 1.8, x: 0, y: 0)
    }
}

public struct LiquidGlassCard: ViewModifier {
    var neonBorder: LinearGradient
    var cornerRadius: CGFloat = 20
    var glowColor: Color = .cyan
    
    public func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color(white: 0.12).opacity(0.45))
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(.ultraThinMaterial)
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(neonBorder, lineWidth: 1.5)
            )
            .shadow(color: glowColor.opacity(0.25), radius: 14, x: 0, y: 6)
    }
}

public extension View {
    func neonGlow(color: Color, radius: CGFloat = 12) -> some View {
        modifier(NeonGlow(color: color, radius: radius))
    }
    
    func liquidGlass(
        glowColor: Color = Color(red: 0.0, green: 0.95, blue: 1.0),
        border: LinearGradient = LinearGradient(
            colors: [Color.cyan.opacity(0.8), Color.purple.opacity(0.5), Color.pink.opacity(0.8)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ),
        cornerRadius: CGFloat = 20
    ) -> some View {
        modifier(LiquidGlassCard(neonBorder: border, cornerRadius: cornerRadius, glowColor: glowColor))
    }
}

public struct CosmicBackground: View {
    @State private var animate = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            Color(red: 0.03, green: 0.03, blue: 0.07)
                .ignoresSafeArea()
            
            Circle()
                .fill(Color(red: 0.0, green: 0.8, blue: 1.0).opacity(0.25))
                .frame(width: 280, height: 280)
                .blur(radius: 70)
                .offset(x: animate ? -120 : -60, y: animate ? -220 : -160)
            
            Circle()
                .fill(Color(red: 0.95, green: 0.05, blue: 0.65).opacity(0.22))
                .frame(width: 320, height: 320)
                .blur(radius: 80)
                .offset(x: animate ? 140 : 80, y: animate ? 180 : 260)
            
            Circle()
                .fill(Color(red: 0.5, green: 0.0, blue: 1.0).opacity(0.2))
                .frame(width: 260, height: 260)
                .blur(radius: 75)
                .offset(x: animate ? -100 : 100, y: animate ? 100 : -50)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 8).repeatForever(autoreverses: true)) {
                animate.toggle()
            }
        }
    }
}
