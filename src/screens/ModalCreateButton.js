import React from 'react';
import { View, Text, StyleSheet, Modal, TextInput, TouchableOpacity } from 'react-native';

const ModalCreateButton = ({ isVisible, onCreateTap }) => {
    const [text, onChangeText] = React.useState("Useless Text");
    return (
        <Modal 
            transparent={true}
            visible={isVisible}
            >
            <View style={styles.modalBackground}>
              <View style={styles.modalView}>
              <Text style={{ fontSize: 30 }}>Create your button!</Text>
              <TextInput 
                style={styles.input}
                onChangeText={onChangeText}
                value={text}
              />
              <TouchableOpacity
              onPress={() => {
                onCreateTap()
              }}>
              <Text >
                  Modal!
                </Text>
          </TouchableOpacity>
                
              </View>
            </View>

          </Modal>
    );
};

const styles = StyleSheet.create({
    input: {
        height: 40,
        margin: 12,
        borderWidth: 1,
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
});

export default ModalCreateButton;