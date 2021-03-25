import React, { useState } from 'react';
import { View, Text, StyleSheet, Modal, TextInput, TouchableOpacity } from 'react-native';
import { v4 as uuid } from 'uuid';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { onChange } from 'react-native-reanimated';

class ModalCreateButton extends React.Component {
//const ModalCreateButton = ({ isVisible, onCreateTap, populateButtonsTap }) => {
    //const [text, onChangeText] = useState("");
    state = {
      inputText: ''
   }

   handleInput = (text) => {
    this.setState({ inputText: text })
  }

  

    
    render() {

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
        } else {
        AsyncStorage.getItem('buttonObj')
        .then((buttonObj) => {
          const b = buttonObj ? JSON.parse(buttonObj) : [];
          b.push(button);
          AsyncStorage.setItem('buttonObj', JSON.stringify(b));
          console.log(b)
        });
      }
      }

    return (
        <Modal 
            transparent={true}
            visible={this.props.isVisible}
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
                //{this.props.isVisible}
                createButton();
                this.props.populateButtonsTap();
                this.props.onCreateTap();
              }}>
              <Text style={styles.buttonText}>
                  Submit
                </Text>
          </TouchableOpacity>
                
              </View>
            </View>

          </Modal>
    );}
};

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

      }

});

export default ModalCreateButton;