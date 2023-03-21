
import SwiftUI


struct ContentView: View {
    @State private var fontSize = Self.fontSizeDefault {
        didSet{
            UserDefaults.standard.set(fontSize, forKey: fontSizeKey)
        }
    }
    @State var noteContents = "Lief dagboek, \n\nVandaag heb ik op avans een kut opdracht gemaakt"
    let fontSizeKey = "nl.avans.alwaysnote.fontsize"
    static let fontSizeDefault = 17.0
    var body: some View {
        VStack{
            titleView
            buttonView
        }.padding()
        VStack{
            editorView
        }.padding()
    }
    
    var titleView: some View {
        VStack{
            Text("AlswaysNote")
                .font(.custom("Hoefler Text", size:60))
                .foregroundColor(.yellow)
        }.padding()
    }
    
    var buttonView: some View {
        HStack{
            Button("Save") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }
            Button("a") {
                decreaseFont()
                saveFontSize()
            }
            Button("A") {
                increaseFont()
                saveFontSize()
            }
        }
    }
    func decreaseFont() { fontSize = max(fontSize - 1.0, 8.0) }
    
    func increaseFont() { fontSize = max(fontSize + 1.0, 8.0) }
    
    func saveFontSize(){
        UserDefaults().set(fontSize, forKey: fontSizeKey)
    }
    
    
    var editorView: some View {
        VStack{
            TextEditor(text: $noteContents)
                .padding()
                .font(.custom("Hoefler Text ", size: CGFloat(fontSize)))
        }
    }
    func initView(){
        let defaults = UserDefaults.standard
        if defaults.object(forKey: fontSizeKey) == nil {
            fontSize = Self.fontSizeDefault
        } else {
            fontSize = defaults.double(forKey: fontSizeKey)
        }
    
    }
    
}











struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


