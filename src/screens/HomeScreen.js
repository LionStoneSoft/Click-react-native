import React from 'react';
import { View, Text, StyleSheet, FlatList, Dimensions, TextInput, Modal,  } from 'react-native';
import { TouchableOpacity } from 'react-native-gesture-handler';
import ButtonTile from '../components/ButtonTile';
import { v4 as uuid } from 'uuid';
import AsyncStorage from '@react-native-async-storage/async-storage';


// const buttonObj = {
//   buttonID: "",
//   title: "",
// }

// const testFunc = (buttonData) => {
//   var {buttonData} = {
//     currentDateTime: Date().toLocaleString(),
//     note: "",
//   }
// }


var data = [
    //{key: 1, title: 'coom', amount: 2},{key: 2, title: 'bum', amount: 2},{key: 3, title: 'poo', amount: 2},{key: 4, title: 'poops', amount: 2},{key: 5, title: 'poo', amount: 2},{key: 6, title: 'poo', amount: 2},{key: 7, title: 'poo', amount: 2},{key: 8, title: 'poo', amount: 2}
];
  
  const formatData = (data, numColumns) => {
    
    const numberOfFullRows = Math.floor(data.length / numColumns);
  
    let numberOfElementsLastRow = data.length - (numberOfFullRows * numColumns);
    while (numberOfElementsLastRow !== numColumns && numberOfElementsLastRow !== 0) {
      data.push({ buttonID: `blank-${numberOfElementsLastRow}`, empty: true });
      numberOfElementsLastRow++;
    }
  
    return data;
  };
  
  const numColumns = 3;
  export default class HomeScreen extends React.Component {
    constructor(props) {
      super(props);
      //const me = this;
      this.populateButtons();
    }


    state = {
      isVisible: false,
      inputText: ''
   }

    handleInput = (text) => {
      this.setState({ inputText: text })
    }

    static navigationOptions = ({navigation, screenProps}) => {
      const params = navigation.state.params || {};
    
      return {
        headerTitle: () => params.headerTitle,
        headerRight: () => params.headerRight,
      }
    }
    
    _setNavigationParams() {
      let headerTitle = <Text style={styles.headerTitle}>Click.</Text>;
      let headerRight = <TouchableOpacity onPress={this._headerButtonPress.bind(this)}>
                          <Text style={styles.headerBtn}>+</Text>
                        </TouchableOpacity>;
      this.props.navigation.setParams({ 
        headerTitle,
        headerRight, 
      });
    }
    
    componentDidMount() {
      this._setNavigationParams();
    }

    _headerButtonPress = () => {
      this.displayModal(true);
    }



    renderItem = ({ item, index }) => {
      if (item.empty === true) {
        return <View style={[styles.item, styles.itemInvisible]} />;
      }
      return (
        <View style={styles.item}>
            <ButtonTile 
                style={styles.item}
                title={item.title}
                buttonID={item.buttonID}
                //amount={item.amount}
            />
        </View>
      );
    };
  
    

    refreshTheList(reload){
      this.setState({
        refresh: reload,
      })
    }

    renderButtonList() {
      return(
        <FlatList
          data={formatData(data, numColumns)}
          style={styles.container}
          renderItem={this.renderItem}
          numColumns={numColumns}
          showsVerticalScrollIndicator={false}
          extraData={this.state.refresh}
        />
      )
    }

    displayModal(show){
      this.setState({
        isVisible: show,
      })
    }

    populateButtons = () => {
      AsyncStorage.getItem('buttonObj')
        .then((buttonObj) => {
          const b = buttonObj ? JSON.parse(buttonObj) : [];
          data = b;
          console.log(b);
          this.refreshTheList(true);
        });
    };
    

    render() {
      modalStateChange = (currentState) => {
        this.displayModal(currentState);
      }      

      
      
      createButton = () => {

        var button = {
          buttonID: uuid(),
          title: this.state.inputText,
        };
        if (AsyncStorage.getItem('buttonObj') == null) {
          const initialArray = [];
          initialArray.push(button);
          AsyncStorage.setItem('buttonObj', initialArray);
          console.log(initialArray)
          this.populateButtons();
        } else {
        AsyncStorage.getItem('buttonObj')
        .then((buttonObj) => {
          const b = buttonObj ? JSON.parse(buttonObj) : [];
          b.push(button);
          AsyncStorage.setItem('buttonObj', JSON.stringify(b));
          console.log(b)
          this.populateButtons();
        });
      }
      }

      return (
        <View style={styles.mainContainer}>
         <View style={styles.mainContainer}>
         {this.renderButtonList()}
         </View>
        {/* modal */}
        <Modal 
            transparent={true}
            visible={this.state.isVisible}
            >
            <View style={styles.modalBackground}>
              <View style={styles.modalView}>
              <Text style={styles.topText}>Create your button!</Text>
              <TextInput 
                style={styles.input}
                //value={text}
                onChangeText={this.handleInput}
                
              />
              <TouchableOpacity
              style={styles.modalButton}
              
              onPress={() => {                
                createButton();
                this.state.isVisible = false
              }}>
              <Text style={styles.buttonText}>
                  Submit
                </Text>
          </TouchableOpacity>
                
              </View>
            </View>

          </Modal>
        </View>
      );
    }

  }
  
  const styles = StyleSheet.create({
    
    topText: {
      fontSize: 20,
      textAlign: 'center'
    },
    input: {
        height: 40,
        margin: 12,
        borderWidth: 1,
        borderRadius: 10,
        alignContent: 'center'
      },
      modalBackground: {
        backgroundColor: "#000000aa",
        flex: 1,
      },
      modalView: {
        backgroundColor: "white",
        margin: 50,
        padding: 40,
        borderRadius: 10,
      },
      modalButton: {
        backgroundColor: "#085",
        borderRadius: 10,
        alignSelf: 'center',
        padding: 10
        //height: 40
      },
      buttonText: {
        fontSize: 20,
        color: "white",
        textAlign: 'center',

      },
    mainContainer: {
      flex: 1,
      //backgroundColor: 'blue',
      justifyContent: 'center',
  },
    container: {
      flex: 1,
      marginVertical: 5,
      marginHorizontal: 5,
    },
    item: {
      backgroundColor: 'transparent',
      alignItems: 'center',
      justifyContent: 'center',
      flex: 1,
      margin: 1,
      height: Dimensions.get('window').width / numColumns, // approximate a square
    },
    itemInvisible: {
      backgroundColor: 'transparent',
    },
    itemText: {
      color: '#fff',
    },
    headerBtn: {
      fontSize: 25,
      color: 'black',
      paddingRight: 20,
    },
    headerTitle: {
      fontSize: 25,
      color: 'black',
    },
    modal: {
      flex: 1,
      alignItems: 'center',
      backgroundColor: '#00ff00',
      padding: 100,
    },
    
  });

