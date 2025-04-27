import os
import math
import numpy as np
from PIL import Image

# returns a string of 12-bit color at row y, column x of image
def get_color_bits(im, y, x):
    r_bits = format(im[y][x][0], '08b')[0:4]
    g_bits = format(im[y][x][1], '08b')[0:4]
    b_bits = format(im[y][x][2], '08b')[0:4]
    return r_bits + g_bits + b_bits

# write to file Verilog HDL, inferring a Xilinx Block RAM ROM
def rom_12_bit(name, im, out_dir, mask=False, rem_x=-1, rem_y=-1):
    os.makedirs(out_dir, exist_ok=True)
    base = os.path.splitext(os.path.basename(name))[0]
    out_filename = os.path.join(out_dir, f"{base}_12_bit_rom.v")

    y_max, x_max, _ = im.shape
    row_width = math.ceil(math.log2(max(1, y_max - 1)))
    col_width = math.ceil(math.log2(max(1, x_max - 1)))
    addr_width = row_width + col_width

    # collect all addr→color mappings
    entries = []
    for y in range(y_max):
        for x in range(x_max):
            addr = format(y, f'0{row_width}b') + format(x, f'0{col_width}b')
            color = get_color_bits(im, y, x)
            entries.append((addr, color))

    with open(out_filename, 'w') as f:
        # module header with closing ); on port list
        f.write(f"module {base}_rom (\n")
        f.write(f"    input wire clk,\n")
        f.write(f"    input wire [{row_width-1}:0] row,\n")
        f.write(f"    input wire [{col_width-1}:0] col,\n")
        f.write(f"    output reg [11:0] color_data\n")
        f.write(");\n\n")
        f.write("    (* rom_style = \"block\" *)\n\n")
        f.write(f"    reg [{row_width-1}:0] row_reg;\n")
        f.write(f"    reg [{col_width-1}:0] col_reg;\n\n")
        f.write("    always @(posedge clk) begin\n")
        f.write("        row_reg <= row;\n")
        f.write("        col_reg <= col;\n")
        f.write("    end\n\n")
        f.write("    always @(*) begin\n")
        f.write(f"        case ({{row_reg, col_reg}})\n")
        for addr, color in entries:
            f.write(f"            {addr_width}'b{addr}: color_data = 12'b{color};\n")
        f.write(f"            default:       color_data = 12'b000000000000;\n")
        f.write("        endcase\n")
        f.write("    end\n")
        f.write("endmodule\n")

# driver: iterate through all PNG files in prompts/ and generate ROMs in v_prompts/
if __name__ == '__main__':
    img_dir = 'prompts'
    out_dir = 'v_prompts'

    for filename in os.listdir(img_dir):
        if filename.lower().endswith('.png'):
            filepath = os.path.join(img_dir, filename)
            print(f"Processing: {filepath}")
            try:
                pil_img = Image.open(filepath).convert('RGB')
                im = np.array(pil_img)
                rom_12_bit(filepath, im, out_dir)
            except Exception as e:
                print(f"  Failed on {filepath}: {e}")
