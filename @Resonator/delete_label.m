function delete_label(obj)

    fig=obj.figure;
    
    delete(findall(fig,'Type','Textbox'));
    
    

end