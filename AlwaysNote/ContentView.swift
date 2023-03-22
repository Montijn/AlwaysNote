
import SwiftUI


struct ContentView: View {
    static let fontSizeDefault = 17.0
    @State private var fontSize = Self.fontSizeDefault {
        didSet{
            UserDefaults.standard.set(fontSize, forKey: fontSizeKey)
        }
    }
    @State var noteContents = "Lief dagboek, \n\nVandaag heb ik op avans een opdracht gemaakt"
    @State private var showAlert = false
    let fontSizeKey = "nl.avans.alwaysnote.fontsize"
    let fileName = "Always-note"
    
    var body: some View {
        VStack{
            VStack{
                titleView
                buttonView
            }.padding()
            Spacer()
            VStack{
                editorView
            }.padding()
        }.onAppear(perform: initView)
            .alert(isPresented: $showAlert,
                   content: {Alert(title: Text("Your note has been stored"))})
        
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
               save()
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
        do{
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            noteContents = try String(contentsOf: fileURL)
        } catch {}
    
    }
    
    func save(){
        do{
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            try noteContents.write(to: fileURL, atomically: true, encoding: String.Encoding.unicode)
        } catch {}
        showAlert = true
    }
}















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


