namespace GiaoDienWiFi
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.label4 = new System.Windows.Forms.Label();
            this.textBox_full_IP = new System.Windows.Forms.TextBox();
            this.button_disconnect = new System.Windows.Forms.Button();
            this.button_connect = new System.Windows.Forms.Button();
            this.textBox_port = new System.Windows.Forms.TextBox();
            this.textBoxIP4 = new System.Windows.Forms.TextBox();
            this.textBox_IP3 = new System.Windows.Forms.TextBox();
            this.textBox_IP2 = new System.Windows.Forms.TextBox();
            this.textBox_IP1 = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.textBox_counterSW0 = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.button_OffRE1 = new System.Windows.Forms.Button();
            this.button_ONRE1 = new System.Windows.Forms.Button();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.textBoxRE0 = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.groupBox5 = new System.Windows.Forms.GroupBox();
            this.pictureBox_RE0 = new System.Windows.Forms.PictureBox();
            this.buttonRE0_OF = new System.Windows.Forms.Button();
            this.buttonRE0_ON = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.groupBox3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.groupBox4.SuspendLayout();
            this.groupBox5.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox_RE0)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 13F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.ForeColor = System.Drawing.Color.Blue;
            this.label1.Location = new System.Drawing.Point(109, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(304, 22);
            this.label1.TabIndex = 0;
            this.label1.Text = "WiFi Communication LAB- server\r\n";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.textBox_full_IP);
            this.groupBox1.Controls.Add(this.button_disconnect);
            this.groupBox1.Controls.Add(this.button_connect);
            this.groupBox1.Controls.Add(this.textBox_port);
            this.groupBox1.Controls.Add(this.textBoxIP4);
            this.groupBox1.Controls.Add(this.textBox_IP3);
            this.groupBox1.Controls.Add(this.textBox_IP2);
            this.groupBox1.Controls.Add(this.textBox_IP1);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Location = new System.Drawing.Point(12, 34);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(275, 222);
            this.groupBox1.TabIndex = 1;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Communication setup";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.ForeColor = System.Drawing.Color.Blue;
            this.label4.Location = new System.Drawing.Point(61, 187);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(146, 17);
            this.label4.TabIndex = 10;
            this.label4.Text = "Design By An 2025";
            // 
            // textBox_full_IP
            // 
            this.textBox_full_IP.BackColor = System.Drawing.Color.Red;
            this.textBox_full_IP.Location = new System.Drawing.Point(20, 150);
            this.textBox_full_IP.Name = "textBox_full_IP";
            this.textBox_full_IP.ReadOnly = true;
            this.textBox_full_IP.Size = new System.Drawing.Size(237, 20);
            this.textBox_full_IP.TabIndex = 9;
            this.textBox_full_IP.Text = "Not Connect\r\n";
            this.textBox_full_IP.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // button_disconnect
            // 
            this.button_disconnect.Location = new System.Drawing.Point(154, 107);
            this.button_disconnect.Name = "button_disconnect";
            this.button_disconnect.Size = new System.Drawing.Size(82, 37);
            this.button_disconnect.TabIndex = 8;
            this.button_disconnect.Text = "Disconnect";
            this.button_disconnect.UseVisualStyleBackColor = true;
            this.button_disconnect.Click += new System.EventHandler(this.button_disconnect_Click);
            // 
            // button_connect
            // 
            this.button_connect.Location = new System.Drawing.Point(30, 107);
            this.button_connect.Name = "button_connect";
            this.button_connect.Size = new System.Drawing.Size(82, 37);
            this.button_connect.TabIndex = 7;
            this.button_connect.Text = "Connect";
            this.button_connect.UseVisualStyleBackColor = true;
            this.button_connect.Click += new System.EventHandler(this.button_connect_Click);
            // 
            // textBox_port
            // 
            this.textBox_port.BackColor = System.Drawing.Color.Yellow;
            this.textBox_port.Location = new System.Drawing.Point(88, 71);
            this.textBox_port.Name = "textBox_port";
            this.textBox_port.Size = new System.Drawing.Size(79, 20);
            this.textBox_port.TabIndex = 6;
            this.textBox_port.Text = "8000";
            this.textBox_port.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // textBoxIP4
            // 
            this.textBoxIP4.BackColor = System.Drawing.Color.Lime;
            this.textBoxIP4.Location = new System.Drawing.Point(229, 35);
            this.textBoxIP4.Name = "textBoxIP4";
            this.textBoxIP4.Size = new System.Drawing.Size(38, 20);
            this.textBoxIP4.TabIndex = 5;
            this.textBoxIP4.Text = "32";
            this.textBoxIP4.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.textBoxIP4.TextChanged += new System.EventHandler(this.textBox4_TextChanged);
            // 
            // textBox_IP3
            // 
            this.textBox_IP3.BackColor = System.Drawing.Color.Lime;
            this.textBox_IP3.Location = new System.Drawing.Point(186, 35);
            this.textBox_IP3.Name = "textBox_IP3";
            this.textBox_IP3.Size = new System.Drawing.Size(37, 20);
            this.textBox_IP3.TabIndex = 4;
            this.textBox_IP3.Text = "2";
            this.textBox_IP3.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // textBox_IP2
            // 
            this.textBox_IP2.BackColor = System.Drawing.Color.Lime;
            this.textBox_IP2.Location = new System.Drawing.Point(141, 35);
            this.textBox_IP2.Name = "textBox_IP2";
            this.textBox_IP2.Size = new System.Drawing.Size(39, 20);
            this.textBox_IP2.TabIndex = 3;
            this.textBox_IP2.Text = "168";
            this.textBox_IP2.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // textBox_IP1
            // 
            this.textBox_IP1.BackColor = System.Drawing.Color.Lime;
            this.textBox_IP1.Location = new System.Drawing.Point(88, 35);
            this.textBox_IP1.Name = "textBox_IP1";
            this.textBox_IP1.Size = new System.Drawing.Size(47, 20);
            this.textBox_IP1.TabIndex = 2;
            this.textBox_IP1.Text = "192";
            this.textBox_IP1.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(6, 74);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(71, 13);
            this.label3.TabIndex = 1;
            this.label3.Text = "Server Port";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(17, 38);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(60, 13);
            this.label2.TabIndex = 0;
            this.label2.Text = "Server IP";
            this.label2.Click += new System.EventHandler(this.label2_Click);
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.textBox_counterSW0);
            this.groupBox2.Controls.Add(this.label5);
            this.groupBox2.Location = new System.Drawing.Point(302, 34);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(200, 100);
            this.groupBox2.TabIndex = 2;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Status switch";
            // 
            // textBox_counterSW0
            // 
            this.textBox_counterSW0.BackColor = System.Drawing.Color.DodgerBlue;
            this.textBox_counterSW0.Location = new System.Drawing.Point(100, 35);
            this.textBox_counterSW0.Name = "textBox_counterSW0";
            this.textBox_counterSW0.ReadOnly = true;
            this.textBox_counterSW0.Size = new System.Drawing.Size(83, 20);
            this.textBox_counterSW0.TabIndex = 1;
            this.textBox_counterSW0.Text = "0";
            this.textBox_counterSW0.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(6, 35);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(79, 13);
            this.label5.TabIndex = 0;
            this.label5.Text = "Counter(SW)";
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.pictureBox1);
            this.groupBox3.Controls.Add(this.button_OffRE1);
            this.groupBox3.Controls.Add(this.button_ONRE1);
            this.groupBox3.Location = new System.Drawing.Point(302, 140);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(200, 109);
            this.groupBox3.TabIndex = 3;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Controll Led RE1";
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::GiaoDienWiFi.Properties.Resources.th__1_1;
            this.pictureBox1.Location = new System.Drawing.Point(15, 28);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(70, 70);
            this.pictureBox1.TabIndex = 2;
            this.pictureBox1.TabStop = false;
            // 
            // button_OffRE1
            // 
            this.button_OffRE1.Location = new System.Drawing.Point(100, 61);
            this.button_OffRE1.Name = "button_OffRE1";
            this.button_OffRE1.Size = new System.Drawing.Size(83, 28);
            this.button_OffRE1.TabIndex = 1;
            this.button_OffRE1.Text = "OFF";
            this.button_OffRE1.UseVisualStyleBackColor = true;
            this.button_OffRE1.Click += new System.EventHandler(this.button_OffRE1_Click);
            // 
            // button_ONRE1
            // 
            this.button_ONRE1.Location = new System.Drawing.Point(100, 28);
            this.button_ONRE1.Name = "button_ONRE1";
            this.button_ONRE1.Size = new System.Drawing.Size(83, 28);
            this.button_ONRE1.TabIndex = 0;
            this.button_ONRE1.Text = "ON";
            this.button_ONRE1.UseVisualStyleBackColor = true;
            this.button_ONRE1.Click += new System.EventHandler(this.button_ONRE1_Click);
            // 
            // groupBox4
            // 
            this.groupBox4.Controls.Add(this.textBoxRE0);
            this.groupBox4.Controls.Add(this.label6);
            this.groupBox4.Location = new System.Drawing.Point(508, 34);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(200, 100);
            this.groupBox4.TabIndex = 4;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "Status switch";
            // 
            // textBoxRE0
            // 
            this.textBoxRE0.BackColor = System.Drawing.Color.DodgerBlue;
            this.textBoxRE0.Location = new System.Drawing.Point(100, 35);
            this.textBoxRE0.Name = "textBoxRE0";
            this.textBoxRE0.ReadOnly = true;
            this.textBoxRE0.Size = new System.Drawing.Size(83, 20);
            this.textBoxRE0.TabIndex = 1;
            this.textBoxRE0.Text = "0";
            this.textBoxRE0.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(6, 35);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(79, 13);
            this.label6.TabIndex = 0;
            this.label6.Text = "Counter(SW)";
            // 
            // groupBox5
            // 
            this.groupBox5.Controls.Add(this.pictureBox_RE0);
            this.groupBox5.Controls.Add(this.buttonRE0_OF);
            this.groupBox5.Controls.Add(this.buttonRE0_ON);
            this.groupBox5.Location = new System.Drawing.Point(508, 141);
            this.groupBox5.Name = "groupBox5";
            this.groupBox5.Size = new System.Drawing.Size(200, 109);
            this.groupBox5.TabIndex = 5;
            this.groupBox5.TabStop = false;
            this.groupBox5.Text = "Controll Led RE0";
            // 
            // pictureBox_RE0
            // 
            this.pictureBox_RE0.Image = global::GiaoDienWiFi.Properties.Resources.th__1_1;
            this.pictureBox_RE0.Location = new System.Drawing.Point(15, 28);
            this.pictureBox_RE0.Name = "pictureBox_RE0";
            this.pictureBox_RE0.Size = new System.Drawing.Size(70, 70);
            this.pictureBox_RE0.TabIndex = 2;
            this.pictureBox_RE0.TabStop = false;
            // 
            // buttonRE0_OF
            // 
            this.buttonRE0_OF.Location = new System.Drawing.Point(100, 26);
            this.buttonRE0_OF.Name = "buttonRE0_OF";
            this.buttonRE0_OF.Size = new System.Drawing.Size(83, 28);
            this.buttonRE0_OF.TabIndex = 1;
            this.buttonRE0_OF.Text = "ON";
            this.buttonRE0_OF.UseVisualStyleBackColor = true;
            this.buttonRE0_OF.Click += new System.EventHandler(this.buttonRE0_OF_Click);
            // 
            // buttonRE0_ON
            // 
            this.buttonRE0_ON.Location = new System.Drawing.Point(100, 60);
            this.buttonRE0_ON.Name = "buttonRE0_ON";
            this.buttonRE0_ON.Size = new System.Drawing.Size(83, 28);
            this.buttonRE0_ON.TabIndex = 0;
            this.buttonRE0_ON.Text = "OFF";
            this.buttonRE0_ON.UseVisualStyleBackColor = true;
            this.buttonRE0_ON.Click += new System.EventHandler(this.buttonRE0_ON_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(716, 261);
            this.Controls.Add(this.groupBox5);
            this.Controls.Add(this.groupBox4);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.label1);
            this.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Name = "Form1";
            this.Text = "Sample InterFace - WiFi Communication";
            this.Load += new System.EventHandler(this.Form1_Load_1);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.groupBox3.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.groupBox4.ResumeLayout(false);
            this.groupBox4.PerformLayout();
            this.groupBox5.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox_RE0)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox textBoxIP4;
        private System.Windows.Forms.TextBox textBox_IP3;
        private System.Windows.Forms.TextBox textBox_IP2;
        private System.Windows.Forms.TextBox textBox_IP1;
        private System.Windows.Forms.TextBox textBox_port;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox textBox_full_IP;
        private System.Windows.Forms.Button button_disconnect;
        private System.Windows.Forms.Button button_connect;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.TextBox textBox_counterSW0;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Button button_OffRE1;
        private System.Windows.Forms.Button button_ONRE1;
        private System.Windows.Forms.GroupBox groupBox4;
        private System.Windows.Forms.TextBox textBoxRE0;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.GroupBox groupBox5;
        private System.Windows.Forms.PictureBox pictureBox_RE0;
        private System.Windows.Forms.Button buttonRE0_OF;
        private System.Windows.Forms.Button buttonRE0_ON;
    }
}

