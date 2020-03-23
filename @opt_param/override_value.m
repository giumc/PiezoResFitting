function override_value(obj,value)

                    obj.min     =   value/2;
                    obj.max     =   value*2;
                    obj.set_value(value);
end
